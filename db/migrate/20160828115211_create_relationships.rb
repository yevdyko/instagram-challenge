class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false
      t.integer :following_id, null: false

      t.timestamps null: false
    end

    add_index :relationships, :follower_id
    add_index :relationships, :following_id
    add_index :relationships, [:follower_id, :following_id], unique: true
  end
end
