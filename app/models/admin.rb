class Admin < ApplicationRecord
  has_secure_password

  include Commentable

  validates_presence_of :email
  validates :password, presence: true, allow_nil: true, :length => { :minimum => 3}
  validates :email, uniqueness: true
  has_many :users, :dependent => :destroy
  has_many :bills, through: :users, :dependent => :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
