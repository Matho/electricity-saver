require 'rails_helper'

RSpec.describe ScheduleCronEventsService do
  describe '#process' do
    before do
      Timecop.freeze(Time.local(2022, 9, 1, 12, 0, 0))
    end

    after do
      Timecop.return
    end

    let(:network) { create(:network)}
    let(:smart_plug_device) { create(:smart_plug_device, network: network)}

    context 'when crons for today exists' do
      let!(:rules) {
        [
          create(:rule, action: :turn_on, smart_plug_device: smart_plug_device, network: network, cron_thursday: '* 7 * * *'),
          create(:rule, action: :turn_off, smart_plug_device: smart_plug_device, network: network, cron_thursday: '* 23 * * *'),
        ]
      }

      it 'works' do
        ScheduleCronEventsService.new(network).process

        scheduled_event_records = ScheduledEvent.all

        expect(scheduled_event_records.length).to eq 2
        expect(scheduled_event_records[1].action).to eq 'turned_on'
        expect(scheduled_event_records[1].network_id).to eq network.id
        expect(scheduled_event_records[1].status).to eq 'scheduled'

        expect(scheduled_event_records[0].action).to eq 'turned_off'
        expect(scheduled_event_records[0].network_id).to eq network.id
        expect(scheduled_event_records[0].status).to eq 'scheduled'
      end
    end

    context 'when NO crons for today exists' do
      let!(:rules) {
        [
          create(:rule, action: :turn_on, smart_plug_device: smart_plug_device, network: network, cron_friday: '* 7 * * *'),
          create(:rule, action: :turn_off, smart_plug_device: smart_plug_device, network: network, cron_friday: '* 23 * * *'),
        ]
      }

      it 'works' do
        ScheduleCronEventsService.new(network).process

        scheduled_event_records = ScheduledEvent.all

        expect(scheduled_event_records.length).to eq 0
      end
    end
  end
end

