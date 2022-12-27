require 'rails_helper'

RSpec.describe Network, type: :model do
  describe 'factory' do
    it 'is valid' do
      expect(build(:network)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:current_states) }
    it { is_expected.to have_many(:endpoint_devices) }
    it { is_expected.to have_many(:event_logs) }
    it { is_expected.to have_many(:ping_stats) }
    it { is_expected.to have_many(:rules) }
    it { is_expected.to have_many(:saved_energies) }
    it { is_expected.to have_many(:scheduled_events) }
    it { is_expected.to have_many(:smart_plug_devices) }
    it { is_expected.to have_many(:uptime_stats) }
  end

  describe 'validations' do
    it {
      expect { should validate_presence_of(:title) }
    }

    it {
      expect { should validate_inclusion_of(:active).in?([ true, false ]) }
    }
  end
end
