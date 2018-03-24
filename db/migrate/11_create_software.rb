class CreateSoftware < ActiveRecord::Migration[5.1]
  def change
    create_table :software do |t|
      t.string :name, limit: 75, null: false
      t.references :vendor, foreign_key: true, null: false
      t.string :version, limit: 50, null: false
      t.integer :year, null: false
      t.references :assignedTo, references: :employee
      t.date :assignedDate
      t.references :hardware, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :custodian, foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.timestamps
    end

    add_foreign_key :software, :employees, column: :assignedTo_id, on_update: :cascade, on_delete: :nullify
  end

  def up
    execute "ALTER TABLE software ADD CONSTRAINT software_year_limit CHECK (year <= date_part('year', CURRENT_DATE))"
  end

  def down
    execute 'ALTER TABLE software DROP CONSTRAINT software_year_limit'
  end
end
