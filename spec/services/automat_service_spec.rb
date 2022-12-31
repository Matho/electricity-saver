require 'rails_helper'

RSpec.describe AutomatService do
  describe '#process' do
    before do
      Timecop.freeze(Time.local(2022, 9, 1, 12, 0, 0))
    end

    after do
      Timecop.return
    end

    context 'when no scheduled events for network' do
      let(:network) { create(:network)}
      let!(:smart_plug_device) { create(:smart_plug_device, network: network) }

      it 'works' do
        AutomatService.new(network).process

        expect(ScheduledEvent.count).to eq 0
      end
    end

    context 'when endpoint devices for network exists' do
      context 'when scheduled event is for turn on action' do
        let(:network) { create(:network)}
        let(:endpoint_devices) {
          [
            create(:endpoint_device, ip_address: '10.0.3.10', active_monitoring: true, needs_to_be_available: true, network: network),
            create(:endpoint_device, ip_address: '10.0.3.11', active_monitoring: true, needs_to_be_available: true, network: network),
          ]
        }
        let!(:uptime_stats) {
          [
            create(:uptime_stat, endpoint_device: endpoint_devices[0], available: false, check_date: Time.current - 1.minute, network: network),
            create(:uptime_stat, endpoint_device: endpoint_devices[1], available: true, check_date: Time.current - 1.minute, network: network),
          ]
        }
        let!(:smart_plug_device) { create(:smart_plug_device, network: network)}
        let!(:scheduled_events) {
          [
            create(:scheduled_event, network: network, smart_plug_device: smart_plug_device, event_date: Time.current - 1.hour,
                   action: :turned_on, status: :scheduled ),
            create(:scheduled_event, network: network, smart_plug_device: smart_plug_device, event_date: Time.current + 1.hour,
                   action: :turned_on, status: :scheduled )
          ]
        }

        it 'works' do
          allow(SmartPlugOnJob).to receive(:perform_later).and_return(nil)

          AutomatService.new(network).process

          scheduled_events[0].reload
          scheduled_events[1].reload

          expect(scheduled_events[0].status).to eq 'finished'
          expect(scheduled_events[1].status).to eq 'scheduled'
        end
      end

      context 'when scheduled event is for turn off action' do
        context 'when it is NOT possible to turn off smart plug' do
          let(:network) { create(:network)}
          let(:endpoint_devices) {
            [
              create(:endpoint_device, ip_address: '10.0.3.10', active_monitoring: true, needs_to_be_available: true, network: network),
              create(:endpoint_device, ip_address: '10.0.3.11', active_monitoring: true, needs_to_be_available: true, network: network),
            ]
          }
          let!(:uptime_stats) {
            [
              create(:uptime_stat, endpoint_device: endpoint_devices[0], available: true, check_date: Time.current - 1.minute, network: network),
              create(:uptime_stat, endpoint_device: endpoint_devices[1], available: false, check_date: Time.current - 1.minute, network: network),
            ]
          }
          let!(:smart_plug_device) { create(:smart_plug_device, network: network)}
          let!(:scheduled_events) {
            [
              create(:scheduled_event, network: network, smart_plug_device: smart_plug_device, event_date: Time.current - 1.hour,
                     action: :turned_off, status: :scheduled ),
              create(:scheduled_event, network: network, smart_plug_device: smart_plug_device, event_date: Time.current + 1.hour,
                     action: :turned_off, status: :scheduled )
            ]
          }


          it 'works' do
            allow(SmartPlugOffJob).to receive(:perform_later).and_return(nil)

            AutomatService.new(network).process

            scheduled_events[0].reload
            scheduled_events[1].reload

            expect(scheduled_events[0].status).to eq 'failed'
            expect(scheduled_events[0].reason).to eq 'Device states: 10.0.3.10(ON) 10.0.3.11(OFF) '
            expect(scheduled_events[1].status).to eq 'scheduled'
          end
        end

        context 'when it is possible to turn off smart plug' do
          let(:network) { create(:network)}
          let(:endpoint_devices) {
            [
              create(:endpoint_device, ip_address: '10.0.3.10', active_monitoring: true, needs_to_be_available: true, network: network),
              create(:endpoint_device, ip_address: '10.0.3.11', active_monitoring: true, needs_to_be_available: true, network: network),
            ]
          }
          let!(:uptime_stats) {
            [
              create(:uptime_stat, endpoint_device: endpoint_devices[0], available: false, check_date: Time.current - 1.minute, network: network),
              create(:uptime_stat, endpoint_device: endpoint_devices[1], available: false, check_date: Time.current - 1.minute, network: network),
            ]
          }
          let!(:smart_plug_device) { create(:smart_plug_device, network: network)}
          let!(:scheduled_events) {
            [
              create(:scheduled_event, network: network, smart_plug_device: smart_plug_device, event_date: Time.current - 1.hour,
                     action: :turned_off, status: :scheduled ),
              create(:scheduled_event, network: network, smart_plug_device: smart_plug_device, event_date: Time.current + 1.hour,
                     action: :turned_off, status: :scheduled )
            ]
          }

          it 'works' do
            allow(SmartPlugOffJob).to receive(:perform_later).and_return(nil)

            AutomatService.new(network).process

            scheduled_events[0].reload
            scheduled_events[1].reload

            expect(scheduled_events[0].status).to eq 'finished'
            expect(scheduled_events[0].reason).to eq nil
            expect(scheduled_events[1].status).to eq 'scheduled'
          end
        end
      end
    end
  end
end

