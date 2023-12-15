class AddCheckInToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :check_in, :date
    add_column :rooms, :check_out, :date
    add_column :rooms, :person, :integer
  end
end
