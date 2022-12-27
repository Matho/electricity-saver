require 'rails_helper'

RSpec.describe PingStatsService do
  describe '#process' do
    let(:network) { create(:network)}

    context 'when no endpoint devices for network' do
      it 'works' do
        PingStatsService.new(network).process

        expect(PingStat.count).to eq 0
        expect(UptimeStat.count).to eq 0
      end
    end

    context 'when endpoint devices for network exists' do
      context 'when both endpoint devices are available' do
        let!(:endpoint_devices) {
          [
            create(:endpoint_device, active_monitoring: true, network: network),
            create(:endpoint_device, active_monitoring: false, network: network),
            create(:endpoint_device, active_monitoring: true, network: network)
          ]
        }

        it 'works' do
          allow_any_instance_of(Net::Ping::External).to receive(:ping?).and_return(true)

          PingStatsService.new(network).process

          expect(PingStat.count).to eq 2
          expect(UptimeStat.count).to eq 2
        end
      end
      context 'when both endpoint devices are available and processing is called twice' do
        let!(:endpoint_devices) {
          [
            create(:endpoint_device, active_monitoring: true, network: network),
            create(:endpoint_device, active_monitoring: false, network: network),
            create(:endpoint_device, active_monitoring: true, network: network)
          ]
        }

        it 'works' do
          allow_any_instance_of(Net::Ping::External).to receive(:ping?).and_return(true)

          PingStatsService.new(network).process
          PingStatsService.new(network).process

          expect(PingStat.count).to eq 4
          expect(UptimeStat.count).to eq 2
        end
      end
    end
  end
end

