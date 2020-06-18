class User < ApplicationRecord

  validates_presence_of :email, :password
  belongs_to :admin
  has_many :bills, :dependent => :destroy
end
