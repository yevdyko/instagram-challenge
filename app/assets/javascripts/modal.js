$(document).on('turbolinks:load', function() {
  $('.btn-options--profile').click(function() {
    $('#modalProfileOptions').modal('show');
  });
  $('.btn-options--post').click(function() {
    $('#modalPostOptions').modal('show');
  });
});
