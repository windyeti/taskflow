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
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }

    context 'Authenticated Author' do
      before { log_in(user) }
      it 'assigns var project' do
        get :edit, params: { id: project }
        expect(assigns(:project)).to eq project
      end
      it 'render template edit' do
        get :edit, params: { id: project }
        expect(response).to render_template :edit
      end
    end
    context 'Authenticated not Author' do
      let(:other_user) { create(:user) }
      before { log_in(other_user) }

      it 'assigns var project' do
        get :edit, params: { id: project }
        expect(assigns(:project)).to eq project
      end
      it 'render template edit' do
        get :edit, params: { id: project }
        expect(response).to redirect_to new_user_session_path
      end
    end
    context 'Authenticated Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before { log_in(admin_user) }

      it 'assigns var project' do
        get :edit, params: { id: project }
        expect(assigns(:project)).to eq project
      end
      it 'render template edit' do
        get :edit, params: { id: project }
        expect(response).to render_template :edit
      end
    end
    context 'Guest' do
      it 'does not assign var project' do
        get :edit, params: { id: project }
        expect(assigns(:project)).to be_nil
      end
      it 'redirect to new_user_seesion' do
        get :edit, params: { id: project }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH#update' do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }

    context 'Authenticated Author' do
      before { log_in(user) }

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
    context 'Authenticated not author' do
      let(:other_user) { create(:user) }
      before do
        log_in(other_user)
      end

      context do
        it 'cannot change project' do
          patch :update, params: {id: project, project: {title: 'New Title'}}
          project.reload
          expect(project.title).to_not eq 'New Title'
        end
        it 'assigns var project' do
          get :update, params: { id: project, project: attributes_for(:project) }
          expect(assigns(:project)).to eq project
        end
        it 'redirect to new_user_session_path' do
          get :update, params: { id: project, project: attributes_for(:project) }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
    context 'Authenticated Admin' do
      let(:admin_user) { create(:user, role: 'Admin') }
      before do
        log_in(admin_user)
      end

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
    end
    end
    context 'Guest' do
      it 'cannot change project' do
        patch :update, params: {id: project, project: {title: 'New Title'}}
        project.reload
        expect(project.title).to_not eq 'New Title'
      end
      it 'does not assign var project' do
        get :update, params: { id: project, project: attributes_for(:project) }
        expect(assigns(:project)).to be_nil
      end
      it 'redirect to new_user_session_path' do
        get :update, params: { id: project, project: attributes_for(:project) }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE#destroy' do
    let(:author_user) { create(:user) }
    let!(:project) { create(:project, user: author_user) }

    context 'Authenticated Author' do
      before do
        log_in(author_user)
      end

      it 'assigns var project' do
        delete :destroy, params: { id: project }, format: :js
        expect(assigns(:project)).to eq project
      end
      it 'render template destroy' do
        delete :destroy, params: { id: project }, format: :js
        expect(response).to render_template :destroy
      end
      it 'change count project' do
        expect do
          delete :destroy, params: { id: project }, format: :js
        end.to change(Project, :count).by(-1)
      end
    end
    context 'Authenticated Not Author' do
      let(:other_user) { create(:user) }
      before do
        log_in(other_user)
      end

      it 'assigns var project' do
        delete :destroy, params: { id: project }, format: :js
        expect(assigns(:project)).to eq project
      end
      it 'return status forbidden' do
        delete :destroy, params: { id: project }, format: :js
        expect(response).to have_http_status :forbidden
      end
      it 'does not change count project' do
        expect do
          delete :destroy, params: { id: project }, format: :js
        end.to_not change(Project, :count)
      end
    end

    context 'Admin' do
      let(:admin) { create(:user, role: 'Admin') }
      before do
        log_in(admin)
      end

      it 'assigns var project' do
        delete :destroy, params: { id: project }, format: :js
        expect(assigns(:project)).to eq project
      end
      it 'render template destroy' do
        delete :destroy, params: { id: project }, format: :js
        expect(response).to render_template :destroy
      end
      it 'change count project' do
        expect do
          delete :destroy, params: { id: project }, format: :js
        end.to change(Project, :count).by(-1)
      end
    end
    context 'Guest' do
      it 'does not assign var project' do
        delete :destroy, params: { id: project }, format: :js
        expect(assigns(:project)).to be_nil
      end
      it 'return status unauthorized' do
        delete :destroy, params: { id: project }, format: :js
        expect(response).to have_http_status :unauthorized
      end
      it 'does not change count project' do
        expect do
          delete :destroy, params: { id: project }, format: :js
        end.to_not change(Project, :count)
      end
    end

  end
end
