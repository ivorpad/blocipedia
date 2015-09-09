class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis

  # Should be collaborations (?) because a User has many collaborations
  # User: has_many :collaborators doesn't sound right
  has_many :collaborators
  has_many :wikis, through: :collaborators

  after_initialize :set_default_role, :if => :new_record?


  # http://stackoverflow.com/questions/2672744/rails-activerecord-find-all-users-except-current-user
  def self.all_except(user)
    where.not(id: user)
  end

  def set_default_role
    self.role ||= 'standard'
  end

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def standard?
    role == 'standard'
  end
end
