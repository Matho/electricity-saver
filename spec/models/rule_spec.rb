require 'rails_helper'

RSpec.describe Rule, type: :model do
  describe 'factory' do
    it 'is valid' do
      expect(build(:rule)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:network) }
    it { is_expected.to belong_to(:smart_plug_device) }
  end

  describe 'validations' do
    it {
      expect { should validate_presence_of(:rule) }
    }
    it {
      expect { should validate_presence_of(:smart_plug_device_id) }
    }
    it {
      expect { should validate_presence_of(:action) }
    }
    it {
      expect { should validate_presence_of(:network) }
    }
  end
end
