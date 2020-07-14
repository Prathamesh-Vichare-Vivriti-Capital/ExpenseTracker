class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true

  validates_presence_of :body, :bill_id, :commentable_type, :commentable_id

end
