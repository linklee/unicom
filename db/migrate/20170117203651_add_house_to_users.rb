class AddHouseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fact_house, :string
  end
end
