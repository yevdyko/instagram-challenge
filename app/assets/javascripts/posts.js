$(document).on('turbolinks:load', function() {
  if ($('#load-more').length === 0) {
    $('#paginator').remove();
  }
});
