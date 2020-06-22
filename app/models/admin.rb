class Admin < ApplicationRecord

  include Commentable

  has_many :users, :dependent => :destroy
  has_many :bills, through: :users
  has_many :comments, as: :commentable, dependent: :destroy
end
