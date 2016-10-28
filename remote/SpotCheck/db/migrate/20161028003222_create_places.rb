class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.float :occupancy
      t.string :location
      t.string :type
      t.text :description

      t.timestamps
    end
  end
end
