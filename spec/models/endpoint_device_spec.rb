require 'rails_helper'

RSpec.describe EndpointDevice, type: :model do
  describe 'factory' do
    it 'is valid' do
      expect(build(:endpoint_device)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:network) }
    it { is_expected.to have_many(:event_logs) }
    it { is_expected.to have_many(:uptime_stats) }
  end

  describe 'validations' do
    it {
      expect { should validate_presence_of(:title) }
    }
    it {
      expect { should validate_presence_of(:network_id) }
    }
    it {
      expect { should validate_inclusion_of(:active_monitoring).in?([ true, false ]) }
    }
    it {
      expect { should validate_presence_of(:ip_address) }
    }
  end
end
