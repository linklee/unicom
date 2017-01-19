class AddFactLocaleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fact_locality_id, :integer
  end
end
