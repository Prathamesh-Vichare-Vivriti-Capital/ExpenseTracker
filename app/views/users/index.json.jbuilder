json.user @users do |user|
  json.id user.id
  json.email user.email
  json.name user.name
  json.employment_status user.employment_status
end
