class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  class Scope < Scope
    def resolve
      user.present? ?
          if user.admin? || user.premium?
            scope
          else
            scope.where(:private => true)
          end :
            scope
    end
  end

end
