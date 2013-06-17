# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#

c = Captain.create(name: 'magic mike', username: 'c', password: 'c', password_confirmation: 'c', email: 'c@c.com')
p = Pirate.create(name: 'magic dog', username: 'p', password: 'p', password_confirmation: 'p', tax_rate: nil)
t = Treasure.create(name: 'dog', description: 'dog', price: 100, tax: 5)

c.pirates << p
c.treasures << t

10.times do |n|
  c.tasks << Task.create(name: "task #{n}", description: 'generated task', worth: n)
end
