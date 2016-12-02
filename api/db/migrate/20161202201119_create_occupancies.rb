class CreateOccupancies < ActiveRecord::Migration[5.0]
  def change
    create_table :occupancies do |t|
      t.string :time
      t.float :score
      t.belongs_to :occupancy_day, foreign_key: true

      t.timestamps
    end
  end
end
