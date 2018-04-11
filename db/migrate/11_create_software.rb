class CreateSoftware < ActiveRecord::Migration[5.1]
  def change
    create_table :software do |t|
      t.string :name, limit: 75, null: false
      t.references :vendor, foreign_key: { on_update: :cascade, on_delete: :restrict }, null: false
      t.string :version, limit: 50, null: false
      t.integer :year, null: false
      t.date :assigned_date
      t.date :license_start_date
      t.date :license_end_date
      t.boolean :active, default: true, null: false
      t.decimal :cost, precision: 10, scale: 2, null: false
      t.string :license_key, limit: 50, null: false
      t.references :hardware, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :custodian, foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.timestamps
    end
  end
end
