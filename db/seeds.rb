# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'yegor.tikhanin@gmail.com', password: '123456', role: 'Admin')

%w(Web/Design Web/Layout Dev Graf/Design Graf/Layout Parsing).each do |typejob|
  Typejob.create(name: typejob)
end
%w(start work done archive).each do |status|
  Status.create(name: status)
end
