class Post < ActiveRecord::Base
  include Voteable
  include Slugable

  belongs_to  :creator, class_name: 'User', foreign_key: :user_id
  has_many    :comments
  has_many    :categories, through: :categorizations
  has_many    :categorizations
  has_many    :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  after_validation :slugify_this

  def slugify_this
    generate_slug(Category, self.title)
  end
end