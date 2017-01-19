class AddLocalityIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :locality_id, :integer
  end
end
