class CreateDealerships < ActiveRecord::Migration[5.0]
  def change
    create_table :dealerships do |t|
      t.string :name
      t.boolean :second_hand

      t.timestamps
    end
  end
end
