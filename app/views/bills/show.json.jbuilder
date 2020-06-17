json.bill do
  json.user_id @bill.user_id
  json.invoice @bill.invoice_number
  json.amount @bill.amount
  json.status @bill.status
end
