class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fact_locality_name
      t.string :fact_street
      t.string :reg_house
      t.string :fact_flat
      t.boolean :same_address
      t.string :reg_locality_name
      t.string :reg_street
      t.string :reg_house
      t.string :reg_flat
      t.string :surname
      t.string :name
      t.string :patronymic
      t.string :mobile_phone
      t.string :email
      t.string :desired_amount
      t.boolean :agree_rules

      t.timestamps null: false
    end
  end
end
