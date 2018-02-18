require("sinatra")
require("sinatra/contrib/all")
# require_relative("controllers/dashboard_controller")
# require_relative("controllers/merchants_controller")
# require_relative("controllers/tags_controller")
# require_relative("controllers/transactions_controller")
require_relative("models/merchant.rb")
require_relative("models/tag.rb")
require_relative("models/transaction.rb")

get "/banked" do
  @sum_total = Transaction.sum_values()
  @tags = Tag.all()
  erb(:"dashboard/index")
end

post "/banked" do
  @sum_total = Transaction.sum_values()
  @tags = Tag.all()
  @tag = Tag.find(params[:id])
  @sum_tag_total = Tag.sum_tag_values(params[:id])
  erb(:"dashboard/index_tag")
end

get "/banked/transactions" do
  @transactions = Transaction.all()
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:"transactions/index")
end

post "/banked/transactions" do
  transaction = Transaction.new(params)
  transaction.save()
  redirect(to("/banked/transactions"))
end

get "/banked/merchants" do
  @merchants = Merchant.all()
  erb(:"merchants/index")
end

post "/banked/merchants" do
  merchant = Merchant.new(params)
  merchant.save()
  redirect(to("/banked/merchants"))
end

get "/banked/tags" do
  @tags = Tag.all()
  erb(:"tags/index")
end

post "/banked/tags" do
  tag = Tag.new(params)
  tag.save()
  redirect(to("/banked/tags"))
end
