class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fact_city, :string
  end
end
