class Car < ApplicationRecord
  validates_presence_of :make, :price, :model

  belongs_to :dealership

  def info
    "#{year} - #{make} #{model}"
  end

  def self.by_make
    order(:make)
  end
  
end
