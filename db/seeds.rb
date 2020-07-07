# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_list = [
  ['prathamesh@gmail.com','abcd','Prathamesh'],
  ['gogo@gmail.com','abcd','Gogo']
]

admin_list = [
  ['vivriti@capital.com','abcd','Vivriti'],
  ['colending@capital.com','abcd','Colending']
]



admin_list.each do |email,password,name|
  Admin.create(email: email, password: password, name: name)
end

user_list.each do |email,password,name|
  User.create(email: email, password: password, name: name, admin_id: 1,employment_status: 'working')
end
