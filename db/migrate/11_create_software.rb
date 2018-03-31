class CreateSoftware < ActiveRecord::Migration[5.1]
  def change
    create_table :software do |t|
      t.string :name, limit: 75, null: false
      t.references :vendor, foreign_key: true, null: false
      t.string :version, limit: 50, null: false
      t.integer :year, null: false
      t.references :assigned_to, references: :employee
      t.date :assigned_date
      t.date :license_start_date, null: false
      t.date :license_end_date, null: false
      t.references :hardware, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :custodian, foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.timestamps
    end

    add_foreign_key :software, :employees, column: :assigned_to_id, on_update: :cascade, on_delete: :nullify
  end

  def up
    execute "ALTER TABLE software ADD CONSTRAINT software_year_limit CHECK (year <= date_part('year', CURRENT_DATE))"
  end

  def down
    execute 'ALTER TABLE software DROP CONSTRAINT software_year_limit'
  end
end
