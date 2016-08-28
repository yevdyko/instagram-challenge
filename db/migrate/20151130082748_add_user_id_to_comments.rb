class AddUserIdToComments < ActiveRecord::Migration[4.2]
  def change
    add_reference :comments, :user, index: true, foreign_key: true
  end
end
