require 'rails_helper'

RSpec.describe Status, type: :model do
  it { should have_many(:projects) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

end
