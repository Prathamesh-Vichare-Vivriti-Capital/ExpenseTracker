json.user @users do |user|
  @bills = user.bills.where(status: 'pending')
  json.bills @bills do |bill|
    json.user_id bill.user_id
    json.bill_id bill.id
    json.invoice_number bill.invoice_number
    json.status bill.status
  end
end
