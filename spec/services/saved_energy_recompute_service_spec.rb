require 'rails_helper'

RSpec.describe SavedEnergyRecomputeService do
  describe '#process' do
    before do
      Timecop.freeze(Time.local(2022, 9, 1, 12, 0, 0))
    end

    after do
      Timecop.return
    end

    let(:network) { create(:network)}
    let!(:smart_plug_device) { create(:smart_plug_device, network: network, energy_price_for_kwh: 0.23, avg_energy_consumption: 50)}

    context 'when 24 hours powered OFF' do
      let!(:current_states) {
        [
          create(:current_state, state: :turned_off, smart_plug_device: smart_plug_device, network: network, created_at: Time.current - 1.day)
        ]
      }

      it 'works' do
        SavedEnergyRecomputeService.new(network).process

        saved_energy_record = SavedEnergy.first

        expect(SavedEnergy.count).to eq 1
        expect(saved_energy_record.day).to eq Date.yesterday
        expect(saved_energy_record.smart_plug_device_id).to eq smart_plug_device.id
        expect(saved_energy_record.powered_on_hours).to eq 0
        expect(saved_energy_record.powered_off_hours).to eq 24
        expect(saved_energy_record.savings).to eq smart_plug_device.avg_energy_consumption * 24
        expect(saved_energy_record.network_id).to eq network.id
        expect(saved_energy_record.total_energy_price).to eq 0.276
        expect(saved_energy_record.energy_price_for_kwh).to eq 0.23
      end
    end

    context 'when 12 hours powered ON' do
      let!(:current_states) {
        [
          create(:current_state, state: :turned_on, smart_plug_device: smart_plug_device, network: network, created_at: Time.current - 1.day)
        ]
      }

      it 'works' do
        SavedEnergyRecomputeService.new(network).process

        saved_energy_record = SavedEnergy.first

        expect(SavedEnergy.count).to eq 1
        expect(saved_energy_record.day).to eq Date.yesterday
        expect(saved_energy_record.smart_plug_device_id).to eq smart_plug_device.id
        expect(saved_energy_record.powered_on_hours).to eq 12
        expect(saved_energy_record.powered_off_hours).to eq 12
        expect(saved_energy_record.savings).to eq 600
        expect(saved_energy_record.network_id).to eq network.id
        expect(saved_energy_record.total_energy_price).to eq 0.138
        expect(saved_energy_record.energy_price_for_kwh).to eq 0.23
      end
    end

    # TODO: cover with another combinations
  end
end

