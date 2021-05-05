# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

puts "Parsing the data.csv to inject it in DB, you can go grab a coffee (even in Brazil) and come back..."
puts "Orders imported :"

Order.destroy_all
Customer.destroy_all
Country.destroy_all
User.destroy_all

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath = 'db/memory-tech-challenge-data.csv'

CSV.foreach(filepath, csv_options) do |row|

  country = Country.where(name: row['country']).first
  unless country
    country = Country.create!(name: row['country'])
  end

  customer = Customer.where(numero: row['customer_id']).first
  unless customer
    customer = Customer.create!(numero: row['customer_id'], country_id: country.id)
  end

  order = Order.where(numero: row['order_id']).first
  if order
    order.total_price += row['quantity'].to_i * row['unit_price'].to_f
    order.save!
  else
    Order.create!(numero: row['order_id'], date: Date.parse(row['date']), total_price: row['quantity'].to_i * row['unit_price'].to_f, country_id: country.id, customer_id: customer.id)
  end
end

Country.create!(name:"All")

puts "#{Order.count} Orders well and slowly imported!"
puts "#{Customer.count} Customers well and slowly imported!"
puts "#{Country.count} Countres well and slowly imported!"

User.create!({
  email: "memory@memory.memory",
  password: "memory"
})

puts "NB : user created"
puts "email: memory@memory.memory"
puts "password : memory"

