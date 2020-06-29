class Admin < ApplicationRecord
  has_secure_password

  include Commentable

  validates_presence_of :email, :password
  validates :email, uniqueness: true
  has_many :users, :dependent => :destroy
  has_many :bills, through: :users, :dependent => :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
