require 'rails_helper'

RSpec.describe CurrentState, type: :model do
  describe 'factory' do
    it 'is valid' do
      expect(build(:current_state)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:network) }
    it { is_expected.to belong_to(:smart_plug_device) }
  end

  describe 'validations' do
    it {
      expect { should validate_presence_of(:state) }
    }
    it {
      expect { should validate_presence_of(:smart_plug_device_id) }
    }
    it {
      expect { should validate_presence_of(:network_id) }
    }
  end

  describe 'callbacks' do
    context 'after_create' do
      describe '#create_event_log' do
        let(:network) { create(:network) }
        let(:smart_plug_device) { create(:smart_plug_device) }
        let!(:current_state) { create(:current_state, network: network, smart_plug_device: smart_plug_device ) }

        it 'works' do
          expect(EventLog.count).to eq(1)
        end
      end
    end
  end
end
