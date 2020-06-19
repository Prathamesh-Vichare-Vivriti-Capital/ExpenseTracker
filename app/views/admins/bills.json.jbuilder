json.bills @bills do |bill|
  json.bill_id bill.id
  json.invoice bill.invoice_number
  json.amount bill.amount
  json.status bill.status
  json.document_attached bill.documents.attached?
  json.user_id bill.user_id
end
