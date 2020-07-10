json.bills @bills do |bill|
  json.id bill.id
  json.invoice_number bill.invoice_number
  json.amount bill.amount
  json.status bill.status
  json.documents_attached bill.documents.attached?
  json.user_id bill.user_id
  json.group_bill_id bill.group_bill_id
end
