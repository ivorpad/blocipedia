class WikiPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  class Scope < Scope
    def resolve
      if user.present?
        if user.admin? || user.premium?
          scope
        else
          scope.where(:private => false)
        end
      else
        scope
      end
    end
  end
end

