class Wiki < ActiveRecord::Base

  belongs_to :user

  has_many :collaborators
  has_many :users, through: :collaborators


  validates :title, length: { minimum: 5 }, presence: true
  after_initialize :set_default_private_option, :if => :new_record?
  default_scope { order('updated_at DESC') }

  scope :visible_to, -> (user) { user ? all : where(private: false) }
  scope :publicly_viewable, -> { where( private: false ) }
  scope :privately_viewable, -> { where( private: true ) }
  scope :changed, -> { where('updated_at > created_at') }
  # Using a Scope is fine and is actually encouraged, but this is more readable for now.
  # def self.visible_to(user)
  #   if user
  #     #Wiki.all
  #     all
  #   else
  #     #Wiki.where(private: false)
  #     where(private: false)
  #   end
  # end

  def self.changed?
    changed.any?
  end

  def set_default_private_option
    self.private ||= false
  end

  # Added to avoid the violation of The Law of Demeter
  # Now we can use @wiki.username to display the username in a view.
  delegate :username,
           :email,
           :to => :user, :allow_nil => true

  def markdown_title
    render_as_markdown(title)
  end

  def markdown_body
    render_as_markdown(body)
  end

  private

  def render_as_markdown(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = { fenced_code_blocks: true }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end


end
