# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

word_array = ('A'..'z').map{|i| i}
int_array = (1..10).map{|i| i}
10.times do
  User.create(
      number: rand(10000),
      firstname: (int_array.map { |i| word_array.sample }).join(''),
      lastname: (int_array.map { |i| word_array.sample }).join(''),
      post_index: rand(999999)
  )
end


100.times do
  Item.create(name: (int_array.map { |i| word_array.sample }).join(''))
end

20.times do
  order = Order.create(user_id: User.ids.sample)
  rand(15).times do
    OrderLine.create(order_id: order.id,
                      item: Item.all.sample,
                      amount: rand(100))
  end
end

