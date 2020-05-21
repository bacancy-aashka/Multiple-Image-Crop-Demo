class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    #------------Single Image Crop-----------------
    # crop_settings = { x: (params[:post][:crop_x]).to_f, y: (params[:post][:crop_y]).to_f, w: (params[:post][:crop_w]).to_f, h: (params[:post][:crop_h]).to_f } if cropping?

    # if @post.image.attached?
    #   if crop_settings.is_a? Hash
    #     # attachment_path = "#{Dir.tmpdir}/#{@post.image.filename}"
    #     image_cropped = MiniMagick::Image.open( params[:post][:image].tempfile.path)

    #     dimensions = "#{crop_settings[:w]}x#{crop_settings[:h]}"
    #     coord = "#{crop_settings[:x]}+#{crop_settings[:y]}"

    #     image_cropped.crop "#{dimensions}+#{coord}"

        
    #     filename = @post.image.filename
    #     content_type = @post.image.content_type
        
    #     @post.image.attach(io: File.open(image_cropped.path), filename:  filename, content_type: content_type)
    #     puts "----Hello--------"  
    #     else
    #       @post.image
    #     end
    #   end

    # ------------------- MULTIPLE IMAGE CROP ------------------
    params[:post][:crop_no].each do |key,value|
      multi_crop(key)
      # if value != ""
        # multi_crop(key)
      # end
    end


    respond_to do |format|
      if @post.save 
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def multi_crop(index)
      
      crop_settings = { x: (params[:post][:crop_x][index]).to_f, y: (params[:post][:crop_y][index]).to_f, w: (params[:post][:crop_w][index]).to_f, h: (params[:post][:crop_h][index]).to_f } if cropping?(index)
      
      index = index.to_i
      image_cropped = MiniMagick::Image.open(params[:post][:images][index].tempfile.path)
      
      if crop_settings.is_a? Hash
        
        # attachment_path = "#{Dir.tmpdir}/#{@post.images[index].filename}"
        # image_cropped = MiniMagick::Image.open(params[:post][:images][index].tempfile.path)

        dimensions = "#{crop_settings[:w]}x#{crop_settings[:h]}"
        coord = "#{crop_settings[:x]}+#{crop_settings[:y]}"
        image_cropped.crop "#{dimensions}+#{coord}"
 
        # filename = @post.images[index].filename
        # content_type = @post.images[index].content_type
        # @post.images[index].attach(io: File.open(image_cropped.path), filename:  filename, content_type: content_type)
        
        
      end
      filename = params[:post][:images][index].original_filename
      content_type =  params[:post][:images][index].content_type
      @post.images.attach(io: File.open(image_cropped.path), filename:  filename, content_type: content_type)

    
    end
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def cropping?(index)
      !params[:post][:crop_x][index].blank? && !params[:post][:crop_y][index].blank? && !params[:post][:crop_w][index].blank? && !params[:post][:crop_h][index].blank?
    end
end
