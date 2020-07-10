class User < ApplicationRecord
  has_secure_password

  include Commentable

  validates_presence_of :email
  validates :password, presence: true, allow_nil: true, :length => { :minimum => 3}
  validates :email, uniqueness: true
  belongs_to :admin
  has_many :bills, :dependent => :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :group_bills, :dependent => :destroy

end
