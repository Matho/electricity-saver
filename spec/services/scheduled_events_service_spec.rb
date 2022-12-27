require 'rails_helper'

RSpec.describe ScheduledEventsService do
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
        output = ScheduledEventsService.new(network).process

        expect(output[1][0].action).to eq 'turn_on'
        expect(output[1][1]).to eq '2022-09-02 07:00:00.000000000 +0200'

        expect(output[0][0].action).to eq 'turn_off'
        expect(output[0][1]).to eq '2022-09-01 23:00:00.000000000 +0200'
      end
    end

    context 'when crons for today dont exist' do
      let!(:rules) {
        [
          create(:rule, action: :turn_on, smart_plug_device: smart_plug_device, network: network, cron_thursday: nil),
          create(:rule, action: :turn_off, smart_plug_device: smart_plug_device, network: network, cron_thursday: nil),
        ]
      }

      it 'works' do
        output = ScheduledEventsService.new(network).process

        expect(output.length).to eq 0
      end
    end
  end
end

