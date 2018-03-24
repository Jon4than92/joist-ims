class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.references :building, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.string :room, limit: 10

      t.timestamps
    end
  end
end
