json.user @bills do |bill|
  json.bill_id bill.id
  json.user_id bill.user_id
  json.invoice bill.invoice_number
  json.amount bill.amount
  json.status bill.status
end
