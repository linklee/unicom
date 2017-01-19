class AddRegCityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reg_city, :string
  end
end
