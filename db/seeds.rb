# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if !(Rails.env.development? || Rails.env.test?)
  puts "Are you nuts? We're in #{Rails.env}! `rake db:seed` will wipe everything! You're a numpty. Exiting now. Actually I might do that now anyway just to teach you a lesson. Or I might not. You'll never know until you check every last little iota of your database just to make sure it's in order. Good riddance."
end

[Product, Promotion].each {|c| c.destroy_all }

Product.create!([{
  id: 1411,
  name: 'Jockey Wheels - Orange',
  price: 15.39,
}, {
  id: 33881,
  name: 'Chain Ring 146mm',
  price: 65.95,
}, {
  id: 13008,
  name: 'Carbon Brake Pads',
  price: 92.00,
}, {
  id: 9101,
  name: 'Front Derailleur - 34.9mm',
  price: 31.22
}])

Promotion.create!([{
  percentage: 10,
  threshold: 20,
}, {
  percentage: 15,
  threshold: 50,
}, {
  percentage: 20,
  threshold: 100,
}])