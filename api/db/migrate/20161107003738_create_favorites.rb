class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.belongs_to :placeid, index: true
      t.belongs_to :deviceid, index: true

      t.timestamps
    end
  end
end
