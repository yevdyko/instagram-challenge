$(document).ready(function() {
  $('.more-comments').click(function() {
    $(this).on('ajax:success', function(event, data) {
      var postId = $(this).data('post-id');
      var link = "<a id='more-comments' data-post-id=" + postId +
                 "data-type='html' data-remote='true' href='/posts/" + postId +
                 "/comments>show more comments</a>";
      $('#comments_' + postId).html(data);
      $('#comments-pagination_' + postId).html(link);
    });
  });
});
