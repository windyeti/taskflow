require 'rails_helper'

feature 'Create project' do
  context 'Authenticated user create project' do
    scenario 'with valid data'
    scenario 'with invalid data'
  end
  context 'Guest cannot create project' do
    scenario 'with valid data'
  end
end
