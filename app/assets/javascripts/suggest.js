$(document).on('turbolinks:load', function(){
$(function() {
  const dataList = function(request, response) {
    $.ajax({
      url: '/suggest',
      dataType: "json",
      type: 'GET',
      cache: true,
      data: { keyword: request.term },
      success: function(o) {
        response(o);
      },
      error: function(XMLHttpRequest, textStatus, errorThrown) {
        response(["なし"]);
      }
    });
  }
  $('#form-search-car-name').autocomplete({
    source: dataList,
    autoFocus: true,
    delay: 300,
    minLength: 2
  })
});
});