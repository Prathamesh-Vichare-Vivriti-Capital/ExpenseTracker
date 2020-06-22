json.comment do
  json.id @comment.id
  json.body @comment.body
  json.bill_id @comment.bill_id
  json.creator @comment.commentable_type
  json.creator_id @comment.commentable_id
end
