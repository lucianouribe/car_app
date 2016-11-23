require 'rails_helper'

RSpec.describe Dealership, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount_of_cars) }

    it do
      should validate_presence_of(:second_hand).
        in_array([true, false])
    end

  end

  describe 'associations' do
    it { should have_many :cars }
  end

  describe 'instance methods' do
    describe '#cars_count' do # instance method goes with the #
      it 'returns the dealership name and the count of cars it currently has' do
        dealership = Dealership.create(name: 'Larry H Miller', amount_of_cars: 4000, second_hand: true)
        expect(dealership.cars_count).to eq("Larry H Miller - 4,000 Cars Available")
      end
    end
  end

  describe 'class methods' do
    describe '.by_name' do # clas method goes with the dot (.)
      it 'returns the dealerships ordered by name' do
        # setup code
        d1 = Dealership.create(name: 'zorro_cars', amount_of_cars: 2, second_hand: true)
        d2 = Dealership.create(name: 'batman_cars', amount_of_cars: 100, second_hand: false)
        d3 = Dealership.create(name: 'superman_cars', amount_of_cars: 200, second_hand: false)

        # assertion code
        by_name = Dealership.all.by_name
        expect(by_name[0].name).to eq(d2.name)
        expect(by_name[1].name).to eq(d3.name)
        expect(by_name[2].name).to eq(d1.name)
      end
    end
  end

end
