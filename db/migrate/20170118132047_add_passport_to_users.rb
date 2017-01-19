class AddPassportToUsers < ActiveRecord::Migration
  def change
    add_column :users, :passport_code, :string
    add_column :users, :passport_date, :date
    add_column :users, :birth_date, :date
  end
end
