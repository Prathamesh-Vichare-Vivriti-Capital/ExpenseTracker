json.group_bills @group_bills do |bill|
  json.id bill.id
  json.name bill.name
  json.total bill.total
  json.user_id bill.user_id
end
