class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :c_type
      t.integer :engine
      t.string :price
      t.string :make
      t.string :model

      t.timestamps
    end
  end
end
