class User < ActiveRecord::Base
  include Slugable

  has_many  :posts
  has_many  :comments
  has_many  :votes

  has_secure_password validations: false

  validates :username,
    presence: true,
    uniqueness: true
  validates :password,
    presence: true,
    length: {minimum: 3},
    on: :create

  after_validation :slugify_this

  def slugify_this
    generate_slug(Category, self.username)
  end

  def admin?
    self.role == 'admin'
  end
end