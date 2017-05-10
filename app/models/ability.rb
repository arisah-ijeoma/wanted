class Ability
  include CanCan::Ability

  def initialize(user)
    if user.try(:admin)
      can :manage, :all
    else
      can [:update, :destroy], Job do |job|
        user == job.user
      end
      can [:create, :read, :apply], Job
    end
  end
end
