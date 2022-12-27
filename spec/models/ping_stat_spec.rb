require 'rails_helper'

RSpec.describe PingStat, type: :model do
  describe 'factory' do
    it 'is valid' do
      expect(build(:ping_stat)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:network) }
  end

  describe 'validations' do
    it {
      expect { should validate_presence_of(:ip_address) }
    }
    it {
      expect { should validate_presence_of(:response_status) }
    }

    it {
      expect { should validate_presence_of(:network_id) }
    }
  end
end
