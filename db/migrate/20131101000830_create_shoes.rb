class CreateShoes < ActiveRecord::Migration
  def change
    create_table :shoes do |t|
      t.string :name
      t.integer :user_id
      t.string :image
      t.string :path

      t.timestamps
    end
  end
end
