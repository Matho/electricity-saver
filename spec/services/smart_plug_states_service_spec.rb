require 'rails_helper'

RSpec.describe SmartPlugStatesService do
  describe '#process' do
    let(:network) { create(:network)}

    context 'with turned on status' do
      let!(:smart_plug_device) { create(:smart_plug_device, network: network,
                                       api_status_url: 'http://10.0.3.100:8123/api/states/switch.smart_zasuvka_1090',
                                       api_title: 'switch.smart_zasuvka_1090',
                                       token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJkZTBmYzBlMWRiZTE0MzA3OWYzNDkxMDExNzIxZmU0YyIsImlhdCI6MTY1NzQ5MzI4MiwiZXhwIjoxOTcyODUzMjgyfQ._SsIsZGIyOSuu9zfWs-_-la-0SDL8cm-h6K8zvbT_mM')}

      it 'do request' do
        instance = SmartPlugStatesService.new(network)

        VCR.use_cassette('smart_plug_status_on') do
          result = instance.process

          current_state = CurrentState.all.first
          expect(result).to be_truthy
          expect(current_state.state).to eq 'turned_on'
        end
      end
    end

    context 'with turned off status' do
      let!(:smart_plug_device) { create(:smart_plug_device, network: network,
                                        api_status_url: 'http://10.0.3.100:8123/api/states/switch.smart_zasuvka_1090',
                                        api_title: 'switch.smart_zasuvka_1090',
                                        token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJkZTBmYzBlMWRiZTE0MzA3OWYzNDkxMDExNzIxZmU0YyIsImlhdCI6MTY1NzQ5MzI4MiwiZXhwIjoxOTcyODUzMjgyfQ._SsIsZGIyOSuu9zfWs-_-la-0SDL8cm-h6K8zvbT_mM')}

      it 'do request' do
        instance = SmartPlugStatesService.new(network)

        VCR.use_cassette('smart_plug_status_off') do
          result = instance.process

          current_state = CurrentState.all.first
          expect(result).to be_truthy
          expect(current_state.state).to eq 'turned_off'
        end
      end
    end

    context 'with unknown status' do
      let!(:smart_plug_device) { create(:smart_plug_device, network: network,
                                        api_status_url: 'http://10.0.3.100:8123/api/states/switch.smart_zasuvka_1090',
                                        api_title: 'switch.smart_zasuvka_1090',
                                        token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJkZTBmYzBlMWRiZTE0MzA3OWYzNDkxMDExNzIxZmU0YyIsImlhdCI6MTY1NzQ5MzI4MiwiZXhwIjoxOTcyODUzMjgyfQ._SsIsZGIyOSuu9zfWs-_-la-0SDL8cm-h6K8zvbT_mM')}

      it 'do request' do
        instance = SmartPlugStatesService.new(network)

        VCR.use_cassette('smart_plug_status_bad_url') do
          result = instance.process

          current_state = CurrentState.all.first
          expect(result).to be_truthy
          expect(current_state.state).to eq 'unknown'
        end
      end
    end
  end
end

