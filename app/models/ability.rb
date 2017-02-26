class Ability
  include CanCan::Ability

  def initialize(user)
      can [:update, :destroy], Job do |job|
        user == job.user
      end
      can [:create, :read], Job
  end
end
