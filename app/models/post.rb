class Post < ActiveRecord::Base
  belongs_to  :creator, class_name: 'User', foreign_key: :user_id
  has_many    :comments
  has_many    :categories, through: :categorizations
  has_many    :categorizations
  has_many    :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  after_validation :generate_slug

  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end

  def generate_slug
    str = to_slug(self.title)
    count = 2
    obj = Post.where(slug: str).first
    while obj && obj != self
    str = str + "-" + count.to_s
    obj = Post.where(slug: str).first
    count += 1
    end
    self.slug = str.downcase
  end

  def to_slug(name)
    #strip the string
    ret = name.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric with dash
    ret.gsub! /\s*[^A-Za-z0-9]\s*/, '-'

    #convert double dashes to single
    ret.gsub! /-+/,"-"

    #strip off leading/trailing dash
    ret.gsub! /\A[-\.]+|[-\.]+\z/,""

    ret
  end

  def to_param
    self.slug
  end
end