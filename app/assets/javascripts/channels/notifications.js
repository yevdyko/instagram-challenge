App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
  },
  disconnected: function() {
  },
  received: function(data) {
    $('.notification__list').prepend("" + data.notification);
    return this.update_counter(data.counter);
  },
  update_counter: function(counter) {
    var $counter, val;
    $counter = $('.notification-count');
    val = parseInt($counter.text());
    val++;
    return $counter.css({
      opacity: 0
    }).text(val).css({
      top: '-10px'
    }).transition({
      top: '-2px',
      opacity: 1
    });
  }
});
