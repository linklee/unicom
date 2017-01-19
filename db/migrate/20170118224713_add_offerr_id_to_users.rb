class AddOfferrIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :offer_id, :integer
  end
end
