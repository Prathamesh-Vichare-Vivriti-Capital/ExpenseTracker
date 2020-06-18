#json.partial! "admins/admin", admin: @admin

json.bills @bills do |bill|
  json.id bill.id
  json.user_id bill.user_id
  json.invoice_number bill.invoice_number
  json.amount bill.amount
end
