$(document).on('turbolinks:load', function(){
  $(function(){
   function buildHTML(count) {
     var html = `<div class="preview-box" id="preview-box__${count}">
                    <div class="upper-box">
                      <img src="" alt="preview" width: 50px height: 50px>
                    </div>
                    <div class="lower-box">
                      <div class="delete-box btn-flat-dashed-border" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
    return html;
   }
   function setLabel() {
     var prevContent = $('.label-content').prev();
     var labelWidth = (1275 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
     $('.label-content').css('width', labelWidth);
   }
   $(document).on('change', '.hidden-field', function() {
     setLabel();
     var id = $(this).attr('id').replace(/[^0-9]/g, '');
     $('.label-box').attr({id: `label-box--${id}`, for: `micropost_images_attributes_${id}_img`});
     var file = this.files[0];
     var reader = new FileReader();
     reader.readAsDataURL(file);
     reader.onload = function() {
       var image = this.result;
       if ($(`#preview-box__${id}`).length == 0) {
         var count = $('.preview-box').length;
         var html = buildHTML(id);
         var prevContent = $('.label-content').prev();
         $(prevContent).append(html);
       }
       $(`#preview-box__${id} img`).attr('src', `${image}`);
       var count = $('.preview-box').length;
       if (count == 5) {
         $('.label-content').hide();
       }
       setLabel();
       if(count < 5) {
         $('.label-box').attr({id: `label-box--${count}`, for: `micropost_images_attributes_${count}_img`});
       }
     }
   });
   $(document).on('click', '.delete-box', function() {
     var count = $('.preview-box').length;
     setLabel(count);
     var id = $(this).attr('id').replace(/[^0-9]/g, '');
     $(`#preview-box__${id}`).remove();
     console.log('new');
     var count = $('.preview-box').length;
     if(count == 4) {
       $('.label-content').show();
     }
     setLabel(count);
     if(id < 5){
       $('.label-box').attr({id: `label-box--${id}`, for: `micropost_images_attributes_${id}_img`});
     }
   });
  });
});

console.log('hoge')