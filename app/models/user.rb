class User < ApplicationRecord

  include Commentable

  validates_presence_of :email, :password
  belongs_to :admin
  has_many :bills, :dependent => :destroy
  has_many :comments, as: :commentable, dependent: :destroy

end
