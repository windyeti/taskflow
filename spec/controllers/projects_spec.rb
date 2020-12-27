require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET#index' do
    let(:projects) { create_list(:project, 3) }
    before { get :index }

    it 'assigns var projects' do
      expect(assigns(:projects)).to match_array(projects)
    end

    it 'render index template' do
      expect(response).to render_template :index
    end
  end
end
