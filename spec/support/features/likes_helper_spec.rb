require 'rails_helper'

module LikesHelpers
  def have_heart_icon
    have_css('a.glyphicon-heart-empty')
  end
end