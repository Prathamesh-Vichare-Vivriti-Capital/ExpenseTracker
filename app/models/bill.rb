class Bill < ApplicationRecord
  belongs_to :user
  has_many_attached :documents, :dependent => :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
