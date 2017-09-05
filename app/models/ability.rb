class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.persisted?
      can :read, :all
      can :create, Review
    end
  end
end
