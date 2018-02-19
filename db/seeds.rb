require_relative("../models/merchant.rb")
require_relative("../models/tag.rb")
require_relative("../models/transaction.rb")
require("pry-byebug")

Merchant.delete_all()
Tag.delete_all()
Transaction.delete_all()

merchant1 = Merchant.new({
  "name" => "Sainsburys"
})
merchant1.save()
merchant2 = Merchant.new({
  "name" => "Dominos"
})
merchant2.save()
merchant3 = Merchant.new({
  "name" => "Bier Halle"
})
merchant3.save()
merchant4 = Merchant.new({
  "name" => "Slouch"
})
merchant4.save()

tag1 = Tag.new({
  "name" => "Food Shop"
})
tag1.save()
tag2 = Tag.new({
  "name" => "Take-away"
})
tag2.save()
tag3 = Tag.new({
  "name" => "Restaurant"
})
tag3.save()
tag4 = Tag.new({
  "name" => "Bar"
})
tag4.save()

transaction1 = Transaction.new({
  "description" => "Weekly shop",
  "value" => 72.59,
  "spend_date" => "01/1/2018",
  "merchant_id" => merchant1.id,
  "tag_id" => tag1.id
})
transaction1.save()
transaction2 = Transaction.new({
  "description" => "Pizza for poker game",
  "value" => 23.99,
  "spend_date" => "14/01/2018",
  "merchant_id" => merchant2.id,
  "tag_id" => tag2.id
})
transaction2.save()
transaction3 = Transaction.new({
  "description" => "Beers while in town",
  "value" => 10,
  "spend_date" => "23/1/2018",
  "merchant_id" => merchant3.id,
  "tag_id" => tag4.id
})
transaction3.save()
transaction4 = Transaction.new({
  "description" => "My round at the social night",
  "value" => 28.45,
  "spend_date" => "3/2/18",
  "merchant_id" => merchant4.id,
  "tag_id" => tag4.id
})
transaction4.save()

binding.pry
nil
