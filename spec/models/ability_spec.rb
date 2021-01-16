require 'rails_helper'

Rspec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'Authenticated user' do
    let(:user) { create(:user) }

    it { should be_able_to :edit, create(:project, user: user) }
  end
end
