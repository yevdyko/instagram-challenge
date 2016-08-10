require 'rails_helper'

module CommentsHelpers
  def write_comment_with(message)
    visit root_path

    fill_in t('comments.add'), with: message.thoughts, match: :first
    click_button t('comments.submit'), match: :first
  end

  def delete_comment
    visit root_path

    click_link t('comments.destroy.link')
  end

  def have_username(user)
    have_css('.username', text: user.username)
  end

  def have_comment(message)
    have_css('.comment-content', text: message.thoughts)
  end

  def have_delete_icon
    have_css('.delete-comment', text: t('comments.destroy.link'))
  end
end
