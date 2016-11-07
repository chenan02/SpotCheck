class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.string :placeid
      t.string :deviceid

      t.timestamps
    end
  end
end
