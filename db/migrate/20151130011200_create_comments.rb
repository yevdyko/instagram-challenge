class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.text :thoughts

      t.timestamps null: false
    end
  end
end
