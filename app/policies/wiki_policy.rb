class WikiPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def show?
    create?
  end

  class Scope < Scope
    def resolve
      if user.present? && (user.admin? || user.premium?)
          scope.all
        else
          scope.where(:private => false)
      end
    end
  end
end

