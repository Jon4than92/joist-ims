class CreateSoftware < ActiveRecord::Migration[5.1]
  def change
    create_table :software do |t|
      t.string :name, limit: 75, null: false
      t.references :vendor, foreign_key: { on_update: :cascade, on_delete: :restrict }, null: false
      t.string :version, limit: 50, null: false
      t.integer :year, null: false
      t.references :employee, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.date :assigned_date
      t.date :license_start_date, null: false
      t.date :license_end_date, null: false
      t.boolean :active, default: true, null: false
      t.references :hardware, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :custodian, foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.timestamps
    end
  end
end
