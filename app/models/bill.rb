class Bill < ApplicationRecord
  belongs_to :user
  has_many_attached :documents
end
