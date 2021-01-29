require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should belong_to :user }
  it { should belong_to :status }

  it { should have_many(:project_typejobs).dependent(:destroy) }
  it { should have_many(:typejobs).through(:project_typejobs) }

  it {should validate_presence_of :title}
end
