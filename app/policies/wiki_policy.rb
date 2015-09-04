class WikiPolicy < ApplicationPolicy


  def create?
    user.present?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def show?
   user.admin? || user.premium?
  end

  class Scope < Scope

    def resolve
      if user.present?
         if user.admin?
          scope.all
         elsif user.premium?
            # placeholder, find for a solution.
            scope.all.where(:user_id => user.id)
         elsif user.standard?
           scope.publicly_viewable
         end
        else
        scope.publicly_viewable
      end
    end
  end
end

