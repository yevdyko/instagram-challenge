class AddPostIdToComments < ActiveRecord::Migration[4.2]
  def change
    add_reference :comments, :post, index: true, foreign_key: true
  end
end
