class Admin < ApplicationRecord
  has_many :users, :dependent => :destroy
  has_many :bills, through: :users
end
