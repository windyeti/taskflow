class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user || User.new

    if user
      user.admin? ? admin : auth_user
    else
      guest
    end
  end

  def admin
    can :manage, :all
  end

  def auth_user
    guest
    can :read, Project
    can :create, Project
    can :update, Project, { user: user }
  end

  def guest
  end
end
