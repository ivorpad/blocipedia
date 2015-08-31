class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, length: { minimum: 5 }, presence: true
  after_initialize :set_default_private_option, :if => :new_record?

  def set_default_private_option
    self.private ||= false
  end

  # Added to avoid the violation of The Law of Demeter
  # Now we can use @wiki.username to display the username in a view.
  delegate :username,
           :email,
           :to => :user, :allow_nil => true
end
