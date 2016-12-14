class CreateOccupancyDays < ActiveRecord::Migration[5.0]
  def change
    create_table :occupancy_days do |t|
      t.integer :day
      t.float :occupancies, array: true, length: 24
      t.belongs_to :place, foreign_key: true

      t.timestamps
    end
  end
end
