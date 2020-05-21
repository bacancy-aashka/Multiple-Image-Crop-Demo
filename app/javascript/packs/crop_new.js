document.addEventListener("turbolinks:load", function(){
  

  // SINGLE IMAGE CROP
  // $('input[name="post[image]"]').on('change', function(){
    
    
  //   var files = $(this)[0].files
  //   var file = files[0]
  //   // $("#view_image").attr("src", window.URL.createObjectURL(file))
  //   document.getElementById("image_div").innerHTML+="<img src="+ window.URL.createObjectURL(file)+" id='view_image' />";
  //   // document.getElementById("image_div").innerHTML+="<input type='text' name='post[crop_j]' >";
  //   var arr = ['x', 'y', 'w', 'h'];
  //     for (j = 0; j < 4; j++) { 
  //       // document.getElementById("image_div").innerHTML += "<p>"+arr[j]+"</p>"
  //       document.getElementById("image_div").innerHTML += "<input type='text' name='post[crop_"+arr[j]+"]' id='post_crop_"+arr[j]+"' >";
  //     }
  //   $("#view_image").cropper('destroy');

    
  //   $("#view_image").cropper({
  //     aspectRatio: NaN,
  //     background: false,
  //     zoomable: false,
  //     minContainerWidth: 0,
  //     crop: function(event) {
  //       $('#post_crop_x').val(event.detail.x)
  //       $('#post_crop_y').val(event.detail.y)
  //       $('#post_crop_w').val(event.detail.width)
  //       $('#post_crop_h').val(event.detail.height)
        
  //     }
  //   });
    
  // });


  // Multiple Image Crop

  $('input[name="post[images][]"]').on('change', function(){

    var image_div = document.getElementById("images_div")
    image_div.innerHTML = ""
    image_div.innerHTML += "<p>*Click On Image To Crop It</p>"
    var count = $(this)[0].files.length
    var files = $(this)[0].files
    
    for (index = 0; index < count; index++) {
      var file = files[index];
      image_div.innerHTML += "<div class='images'><img src="+ window.URL.createObjectURL(file)+" id='view_image_"+index+"' style='margin:5px;' /></div><br>"
      
      var arr = ['x', 'y', 'w', 'h', 'no'];
      for (j = 0; j < 5; j++) { 
        // image_div.innerHTML += "<p>"+arr[j]+"</p>"
        image_div.innerHTML += "<input type='hidden' name='post[crop_"+arr[j]+"]["+index+"]' id='post_crop_multi_"+arr[j]+"_"+index+"' >";
      }    
    }

    for (let i = 0; i < count; i++) {
      $("#view_image_"+i).cropper({
        aspectRatio: NaN,
        background: false,
        zoomable: false,
        autoCrop: false,
        minContainerWidth: 0,
        crop: function(event) {
          $('#post_crop_multi_x_'+i).val(event.detail.x)
          $('#post_crop_multi_y_'+i).val(event.detail.y)
          $('#post_crop_multi_w_'+i).val(event.detail.width)
          $('#post_crop_multi_h_'+i).val(event.detail.height)
          $('#post_crop_multi_no_'+i).val(i)
          
        }
      });
      
    }
    
    
  });
})