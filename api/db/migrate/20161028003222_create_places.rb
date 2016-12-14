class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :place_id
      t.string :name
      t.string :address
      t.float :lat
      t.float :lng
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
