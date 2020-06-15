$(document).on('turbolinks:load', function(){
$(function() {
  const dataList = function(request, response) {
    $.ajax({
      url: '/suggest',
      dataType: "json",
      type: 'GET',
      cache: true,
      data: { keyword: request.term }
    })
    .then(
      function (o) {
        response(o);
      },
      function (XMLHttpRequest, textStatus, errorThrown) {
        response([""]);
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