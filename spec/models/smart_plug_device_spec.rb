require 'rails_helper'

RSpec.describe SmartPlugDevice, type: :model do
  describe 'factory' do
    it 'is valid' do
      expect(build(:smart_plug_device)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:network) }
    it { is_expected.to have_many(:current_states) }
    it { is_expected.to have_many(:rules) }
    it { is_expected.to have_many(:event_logs) }
  end

  describe 'validations' do
    it {
      expect { should validate_presence_of(:title) }
    }
    it {
      expect { should validate_presence_of(:api_title) }
    }
    it {
      expect { should validate_presence_of(:current_state) }
    }
    it {
      expect { should validate_presence_of(:api_status_url) }
    }
    it {
      expect { should validate_presence_of(:api_turn_on_url) }
    }
    it {
      expect { should validate_presence_of(:api_turn_off_url) }
    }
    it {
      expect { should validate_presence_of(:network_id) }
    }
    it {
      expect { should validate_presence_of(:energy_price_for_kwh) }
    }
    it {
      expect { should validate_presence_of(:avg_energy_consumption) }
    }
    it {
      expect { should validate_presence_of(:token) }
    }
  end
end
