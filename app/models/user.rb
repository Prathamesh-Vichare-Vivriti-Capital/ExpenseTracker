class User < ApplicationRecord
  validates_presence_of :email, :password

  has_many :employees, class_name: "User", foreign_key: "admin_id"

  belongs_to :admin, class_name: "User", optional: true
end
