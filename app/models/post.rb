class Post < ApplicationRecord
  # has_one_attached :image
  has_many_attached :images
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :crop_no
end
