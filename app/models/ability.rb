class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, [Category, Book]

    if user.admin?
      can :manage, :all
    elsif user.persisted?
      can :create, Review
      can :read, Order, user_id: user.id
      can :continue_shopping, Order, user_id: user.id
    end
  end
end
