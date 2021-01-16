require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET#index' do
    let(:projects) { create_list(:project, 3) }

    context 'Authenticated user' do
      let(:user) { create(:user) }
      before do
        log_in(user)
        get :index
      end

      it 'assigns var projects' do
        expect(assigns(:projects)).to match_array(projects)
      end

      it 'assigns var project' do
        expect(assigns(:project)).to be_a_new Project
      end

      it 'render index template' do
        expect(response).to render_template :index
      end
    end

    context 'Guest' do
      before { get :index }

      it 'dont assigns var projects' do
        expect(assigns(:projects)).to be_nil
      end

      it 'dont assigns var project' do
        expect(assigns(:projects)).to be_nil
      end

      it 'redirect to log in' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST#create' do
    let(:user) { create(:user) }

    context 'Authenticated user' do
      before { log_in(user) }

      context 'with valid data can create project' do

        it 'change count projects' do
          expect do
            post :create, params: {project: attributes_for(:project)}, format: :json
          end.to change(Project, :count).by(1)
        end

        it 'return status success' do
          post :create, params: {project: attributes_for(:project)}, format: :json
          expect(response).to have_http_status :success
        end
      end

      context 'with wrong data cannot create project' do
        it 'dont change count projects' do
          expect do
            post :create, params: {project: attributes_for(:project, :invalid_project)}, format: :json
          end.to_not change(Project, :count)
        end
        it 'return status unprocessable_entity' do
          post :create, params: {project: attributes_for(:project, :invalid_project)}, format: :json
          expect(response).to have_http_status :unprocessable_entity
        end
      end
    end

    context 'Guest' do
      it 'dont change count projects' do
        expect do
          post :create, params: {project: attributes_for(:project)}
        end.to_not change(Project, :count)
      end
      it 'redirect to log in' do
        post :create, params: {project: attributes_for(:project)}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET#show' do
    let(:project) { create(:project) }

    context 'Authenticated user' do
      let(:user) { create(:user) }
      before { log_in(user) }

      it 'assigns var @project' do
        get :show, params: {id: project}
        expect(assigns(:project)).to eq project
      end

      it 'render template show' do
        get :show, params: {id: project}
        expect(response).to render_template :show
      end
    end
    context 'Guest' do
      it 'does not assign var @project' do
        get :show, params: {id: project}
        expect(assigns(:project)).to be_nil
      end
      it 'redirect to new_user_session' do
        get :show, params: {id: project}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET#edit' do
    let(:project) { create(:project) }
    let(:user) { create(:user) }
    before { log_in(user) }

    context 'Authenticated Author' do
      it 'assigns var project' do
        get :edit, params: { id: project }
        expect(assigns(:project)).to eq project
      end
      it 'render template edit' do
        get :edit, params: { id: project }
        expect(response).to render_template :edit
      end
    end
    context 'Authenticated Admin'
      it 'assigns var project'
      it 'render template edit'
    context 'Guest'
      it 'does not assign var project'
      it 'redirect to new_user_seesion'
  end

  describe 'PATCH#update' do
    let(:project) { create(:project) }
    let(:user) { create(:user) }
    before { log_in(user) }

    context 'Authenticated Author' do
      context 'with valid data' do
        it 'can change project' do
          patch :update, params: {id: project, project: {title: 'New Title'}}
          project.reload
          expect(project.title).to eq 'New Title'
        end
        it 'assigns var project' do
          get :update, params: { id: project, project: attributes_for(:project) }
          expect(assigns(:project)).to eq project
        end
        it 'redirect to root' do
          get :update, params: { id: project, project: attributes_for(:project) }
          expect(response).to redirect_to root_path
        end
      end
      context 'with invalid data' do
        it 'cannot change project' do
          patch :update, params: {id: project, project: attributes_for(:project, :invalid_project)}
          project.reload
          expect(project.title).to eq 'MyTitle'
        end
        it 'assigns var project' do
          get :update, params: { id: project, project: attributes_for(:project, :invalid_project) }
          expect(assigns(:project).title).to eq ''
        end
        it 'render template edit' do
          get :update, params: { id: project, project: attributes_for(:project, :invalid_project) }
          expect(response).to render_template :edit
        end
      end
    end
    context 'Authenticated Admin'
    context 'Guest'
  end
end
