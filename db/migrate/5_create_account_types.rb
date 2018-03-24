class CreateAccountTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :account_types do |t|
      t.string :name, limit: 25, null: false

      t.timestamps
    end

    add_index :account_types, :name, unique: true
  end
end
