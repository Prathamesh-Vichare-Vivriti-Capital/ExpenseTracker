json.user do
  json.id @user.id
  json.email @user.email
  json.name @user.name
  json.status @user.employment_status
end
