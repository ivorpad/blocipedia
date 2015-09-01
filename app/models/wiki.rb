class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, length: { minimum: 5 }, presence: true
  after_initialize :set_default_private_option, :if => :new_record?
  default_scope { order('updated_at DESC') }

  #scope :visible_to, -> (user) { user ? all : where(private: false) }

  # Using a Scope is fine and is actually encouraged, but this is more readable for now.
  def self.visible_to(user)
    if user
      #Wiki.all
      all
    else
      #Wiki.where(private: false)
      where(private: false)
    end
  end

  def set_default_private_option
    self.private ||= false
  end

  # Added to avoid the violation of The Law of Demeter
  # Now we can use @wiki.username to display the username in a view.
  delegate :username,
           :email,
           :to => :user, :allow_nil => true
end
