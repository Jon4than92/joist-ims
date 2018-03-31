class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.references :building, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.string :name, limit: 25, null: false

      t.timestamps
    end
  end
end
