class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.float :occupancy
      t.string :address
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
