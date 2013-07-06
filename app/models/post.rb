class Post < ActiveRecord::Base
  belongs_to :user
  has_many  :comments
  has_many :categories, through: :categorizations
  has_many :categorizations

  def creator
    self.user
  end
end