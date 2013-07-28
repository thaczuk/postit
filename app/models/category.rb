class Category < ActiveRecord::Base
  include Slugable

  has_many :categorizations
  has_many :posts, through: :categorizations

  validates :name, presence: true, uniqueness: true

  after_validation :slugify_this

  def slugify_this
    generate_slug(Category, self.name)
  end
end