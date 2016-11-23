class CreateDealerships < ActiveRecord::Migration[5.0]
  def change
    create_table :dealerships do |t|
      t.string :name
      t.integer :amount_of_cars
      t.boolean :second_hand

      t.timestamps
    end
  end
end
