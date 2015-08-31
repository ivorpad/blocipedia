class Sunspot::Search::PaginatedCollectionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
end