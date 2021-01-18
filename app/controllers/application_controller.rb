class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to new_user_session_path, alert: exception.message  }
      format.js { render status: :forbidden }
      format.json { render json: { message: exception.message }, status: :forbidden }
    end
  end

end
