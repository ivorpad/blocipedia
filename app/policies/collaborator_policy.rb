class CollaboratorPolicy < ApplicationPolicy

  def create?
    user.premium? || user.admin?
  end

  def edit?
    create?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
