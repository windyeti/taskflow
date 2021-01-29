require 'rails_helper'

RSpec.describe Typejob, type: :model do
  it { should have_many(:project_typejobs).dependent(:destroy) }
  it { should have_many(:projects).through(:project_typejobs) }

  it { should validate_presence_of(:name) }

  describe 'return name of instance' do
    subject(:typejob) { create(:typejob, name: 'NewUniqName') }
    it '' do
      expect(typejob.just_name).to eq 'NewUniqName'
    end
  end
end
