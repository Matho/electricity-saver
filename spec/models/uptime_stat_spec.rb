require 'rails_helper'

RSpec.describe UptimeStat, type: :model do
  describe 'factory' do
    it 'is valid' do
      expect(build(:uptime_stat)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:network) }
    it { is_expected.to belong_to(:endpoint_device) }
  end

  describe 'validations' do
    it {
      expect { should validate_presence_of(:endpoint_device_id) }
    }
    it {
      expect { should validate_inclusion_of(:available).in?([true, false]) }
    }
    it {
      expect { should validate_presence_of(:network_id) }
    }
  end

  describe 'callbacks' do
    context 'after_create' do
      describe '#create_event_log' do
        let(:network) { create(:network) }
        let(:endpoint_device) { create(:endpoint_device) }
        let!(:uptime_stat) { create(:uptime_stat, network: network, endpoint_device: endpoint_device ) }

        it 'works' do
          expect(EventLog.count).to eq(1)
        end
      end
    end
  end
end
