require 'rails_helper'

RSpec.describe Car, type: :model do


  describe 'validations' do
    it { should validate_presence_of(:make) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:model) }

  end

  describe 'associations' do
    it { should belong_to :dealership }
  end

  describe 'instance methods' do
    describe '#info' do # instance method goes with the #
      it 'returns the dealership name and the count of cars it currently has' do
        car = Car.create(make: 'Subaru', model: 'STI', year: 2004, price: '1000', engine: 2000, c_type: 'sedan')
        expect(car.info).to eq("2004 - Subaru STI")
      end
    end
  end

  describe 'class methods' do
    describe '.by_make' do # clas method goes with the dot (.)
      it 'returns the dealerships ordered by name' do
        # setup code
        car1 = Car.create(make: 'Toyota', model: 'LandCruiser', year: 2004, price: '1000', engine: 2000, c_type: 'sedan')
        car2 = Car.create(make: 'Subaru', model: 'STI', year: 2008, price: '1000', engine: 2000, c_type: 'sedan')
        car3 = Car.create(make: 'Alfa Romeo', model: 'Mito', year: 2010, price: '1000', engine: 2000, c_type: 'sedan')
        # assertion code
        by_make = Car.all.by_make
        expect(by_make[0].name).to eq(car3.make)
        expect(by_make[1].name).to eq(car2.make)
        expect(by_make[2].name).to eq(car1.make)
      end
    end
  end

end
