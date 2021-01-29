require 'rails_helper'

RSpec.describe ProjectTypejob, type: :model do
  it { should belong_to :project }
  it { should belong_to :typejob }
end
