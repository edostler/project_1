require("sinatra")
require("sinatra/contrib/all")
require_relative("controllers/merchants_controller")
require_relative("controllers/tags_controller")
require_relative("controllers/transactions_controller")
require_relative("models/merchant.rb")
require_relative("models/tag.rb")
require_relative("models/transaction.rb")

set :environment, :production

get "/banked" do
  @sum_total = Transaction.sum_values()
  @tags = Tag.all()
  @merchants = Merchant.all()
  @budget = 200.00
  erb(:"dashboard/index")
end

post "/banked/filter_tag" do
  @sum_total = Transaction.sum_values()
  @tags = Tag.all()
  @merchants = Merchant.all()
  @budget = 200.00
  @tag = Tag.find(params[:id])
  @sum_tag_total = Tag.sum_tag_values(params[:id])
  erb(:"dashboard/index_filter_tag")
end

post "/banked/filter_merchant" do
  @sum_total = Transaction.sum_values()
  @tags = Tag.all()
  @merchants = Merchant.all()
  @budget = 200.00
  @merchant = Merchant.find(params[:id])
  @sum_merchant_total = Merchant.sum_merchant_values(params[:id])
  erb(:"dashboard/index_filter_merchant")
end

post "/banked/filter_date" do
  @sum_total = Transaction.sum_values()
  @tags = Tag.all()
  @merchants = Merchant.all()
  @budget = 200.00
  @sum_date_total = Transaction.sum_date_values(params[:start_date], params[:end_date])
  @start_date = params[:start_date]
  @end_date = params[:end_date]
  @start_date_formatted = Transaction.format_date(params[:start_date])
  @end_date_formatted = Transaction.format_date(params[:end_date])
  erb(:"dashboard/index_filter_date")
end
