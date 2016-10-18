module NotificationsHelpers
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

  def have_notice_type(type)
    have_css('.notifications .notification',
             text: t("notifications.item.#{type}",
             username: notified_by_user.username))
  end
end
