class AddTotleToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :totle, :bigint
  end
end
