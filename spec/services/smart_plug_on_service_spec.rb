require 'rails_helper'

RSpec.describe SmartPlugOnService do
  describe '#process' do
    let(:network) { create(:network)}

    context 'with positive scenario' do
      let(:smart_plug_device) { create(:smart_plug_device, network: network,
                                       api_turn_on_url: 'http://10.0.3.100:8123/api/services/switch/turn_on',
                                       api_title: 'switch.smart_zasuvka_1090',
                                       token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJkZTBmYzBlMWRiZTE0MzA3OWYzNDkxMDExNzIxZmU0YyIsImlhdCI6MTY1NzQ5MzI4MiwiZXhwIjoxOTcyODUzMjgyfQ._SsIsZGIyOSuu9zfWs-_-la-0SDL8cm-h6K8zvbT_mM')}

      it 'do request' do
        instance = SmartPlugOnService.new(smart_plug_device)

        VCR.use_cassette('smart_plug_on') do
          result = instance.process

          expect(result).to be_truthy
        end
      end
    end

    context 'with negative scenario' do
      let(:smart_plug_device) { create(:smart_plug_device, network: network,
                                       api_turn_on_url: 'http://localhost',
                                       api_title: 'switch.smart_zasuvka_1090',
                                       token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJkZTBmYzBlMWRiZTE0MzA3OWYzNDkxMDExNzIxZmU0YyIsImlhdCI6MTY1NzQ5MzI4MiwiZXhwIjoxOTcyODUzMjgyfQ._SsIsZGIyOSuu9zfWs-_-la-0SDL8cm-h6K8zvbT_mM')}

      it 'do request' do
        instance = SmartPlugOnService.new(smart_plug_device)

        VCR.use_cassette('smart_plug_on_bad_example') do
          result = instance.process

          expect(result).to be_falsey
        end
      end
    end
  end
end

