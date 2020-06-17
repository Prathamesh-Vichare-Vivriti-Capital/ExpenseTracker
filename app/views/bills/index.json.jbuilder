json.user @bills do |bill|
  json.user_id bill.user_id
  json.invoice bill.invoice_number
  json.amount bill.amount
end
