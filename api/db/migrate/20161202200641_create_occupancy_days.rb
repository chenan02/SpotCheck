class CreateOccupancyDays < ActiveRecord::Migration[5.0]
  def change
    create_table :occupancy_days do |t|
      t.belongs_to :place, foreign_key: true
      t.integer :name

      t.timestamps
    end
  end
end
