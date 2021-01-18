require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'Authenticated user' do
    let(:user) { create(:user) }

    it { should be_able_to :read, Project }
    it { should be_able_to :create, Project }
    it { should be_able_to :update, create(:project, user: user) }
  end
  describe 'Authenticated Admin' do
    let(:user) { create(:user, role: 'Admin') }

    it { should be_able_to :manage, :all }
  end
end
