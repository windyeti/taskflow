class RegistrationsController < Devise::RegistrationsController
  # only admin can create new user
  before_action :auth_admin

  # allow authenticated user create a new user (registration)
  # i.e. prevented default devise behaving
  skip_before_action :require_no_authentication, only: [:new, :create]

  def new
    super
  end

  def create
    super
  end

  private

  def auth_admin
    redirect_to new_user_session_path unless current_user&.admin?
  end
end 
