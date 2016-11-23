require 'rails_helper'

RSpec.describe Dealership, type: :model do

  describe 'associations' do
    it { should have_many :cars }
  end

end
