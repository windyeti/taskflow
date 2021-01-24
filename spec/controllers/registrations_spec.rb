require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe 'GET#new' do

    context 'Admin' do
      let(:admin) { create(:user, role: 'Admin') }
      before do
        log_in(admin)
        get :new
      end

      context do
        it 'render template registration' do
          expect(response).to render_template :new
        end
      end
    end

    context 'User' do
      let(:user) { create(:user) }
      before do
        log_in(user)
        get :new
      end
      it 'redirect to new_user_session_path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
    context 'Guest' do
      it 'redirect to new_user_session_path' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  describe 'POST#create' do
    context 'Admin' do
      let(:admin) { create(:user, role: 'Admin') }
      before do
        log_in(admin)
        post :create, params: {user: attributes_for(:user)}
      end

      context do
        it 'render template registration' do
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'User' do
      let(:user) { create(:user) }
      before do
        log_in(user)
        post :create, params: {user: attributes_for(:user)}
      end
      it 'redirect to new_user_session_path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
    context 'Guest' do
      it 'redirect to new_user_session_path' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, params: {user: attributes_for(:user)}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
