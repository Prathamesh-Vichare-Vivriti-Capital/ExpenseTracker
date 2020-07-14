class GroupBill < ApplicationRecord
  belongs_to :user
  has_many :bills, :dependent => :destroy
  validates_presence_of :name
  attribute :total, :float, default: 0
end
