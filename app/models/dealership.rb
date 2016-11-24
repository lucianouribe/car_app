class Dealership < ApplicationRecord
  validates_presence_of :name, :amount_of_cars, :second_hand

  has_many :cars

  def cars_count
    "#{name} - #{amount_of_cars} Cars Available"
  end

  def self.by_name
    order(:name)
  end

end
