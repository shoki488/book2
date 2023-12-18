class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :facility_name
      t.integer :price
      t.string :image
      t.text :introduction
      t.string :address

      t.timestamps
    end
  end
end
