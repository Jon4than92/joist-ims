class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :employee, foreign_key: { on_update: :cascade, on_delete: :cascade }, null: false
      t.string :email, limit: 75, null: false
      t.string :password, limit: 75, null: false
      t.references :account_type, foreign_key: true, null: false

      t.timestamps
    end

    add_index :accounts, :email, unique: true
  end
end
