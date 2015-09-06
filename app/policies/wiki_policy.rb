class WikiPolicy < ApplicationPolicy


  def create?
    user.present?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  class Scope < Scope

    def resolve
      if user.present?
         if user.admin?
          scope.all
         elsif user.premium?
            # http://stackoverflow.com/questions/9540801/combine-two-activerecordrelation-objects
           scope.where(
               scope.arel_table[:user_id].eq(user.id).or(
                   scope.arel_table[:private].eq(false)
               )
           )

         elsif user.standard?
           scope.publicly_viewable
         end
        else
        scope.publicly_viewable
      end
    end
  end
end

