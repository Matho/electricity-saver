require 'rails_helper'

RSpec.describe EventLog, type: :model do
  describe 'factory' do
    it 'is valid' do
      expect(build(:event_log)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:network) }
    it { is_expected.to belong_to(:event_loggable) }
  end

  describe 'validations' do
    it {
      expect { should validate_presence_of(:status) }
    }
    it {
      expect { should validate_presence_of(:event_date) }
    }

    it {
      expect { should validate_presence_of(:event_loggable) }
    }

    it {
      expect { should validate_presence_of(:network_id) }
    }
  end

  describe 'callbacks' do
    context 'after_create' do
      describe '#create_scheduled_event' do
        context 'when smart plug device provided' do
          let(:network) { create(:network) }
          let(:smart_plug_device) { create(:smart_plug_device, network: network) }
          let!(:event_log) { create(:event_log, network: network, event_loggable: smart_plug_device ) }

          it 'works' do
            expect(ScheduledEvent.count).to eq(0)
          end
        end

        context 'when endpoint device provided' do
          context 'when turned_on state' do
            let(:network) { create(:network) }
            let(:endpoint_device) { create(:endpoint_device) }
            let!(:smart_plug_device) { create(:smart_plug_device, network: network) }
            let!(:event_log) { create(:event_log, network: network, event_loggable: endpoint_device, status: :turned_on ) }

            it 'works' do
              expect(ScheduledEvent.count).to eq(1)
            end
          end

          context 'when turned_off state' do
            let(:network) { create(:network) }
            let(:endpoint_device) { create(:endpoint_device) }
            let!(:smart_plug_device) { create(:smart_plug_device, network: network) }
            let!(:event_log) { create(:event_log, network: network, event_loggable: endpoint_device, status: :turned_off ) }

            it 'works' do
              expect(ScheduledEvent.count).to eq(1)
            end
          end

          context 'when unknown state' do
            let(:network) { create(:network) }
            let(:endpoint_device) { create(:endpoint_device) }
            let!(:smart_plug_device) { create(:smart_plug_device, network: network) }
            let!(:event_log) { create(:event_log, network: network, event_loggable: endpoint_device, status: :unknown ) }

            it 'works' do
              expect(ScheduledEvent.count).to eq(0)
            end
          end
        end
      end
    end
  end
end
