module NotificationsHelpers
  def have_icon_flag
    have_css('span.glyphicon-flag')
  end

  def have_notification_count(text)
    have_css('.dropdown-toggle', text: text)
  end

  def have_unread_notifications(count)
    have_css('.dropdown-menu .notification', count: count)
  end

  def have_displayed_notifications(count)
    have_css('.notifications .notification', count: count)
  end

  def have_paginator_link
    have_css('.paginator-link')
  end
end
