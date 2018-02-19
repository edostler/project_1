require_relative("../models/merchant")
require_relative("../models/tag")
require_relative("../models/transaction")

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

get "/banked/transactions/:id" do
  @transaction = Transaction.find(params[:id])
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:"transactions/show")
end

post "/banked/transactions/:id/edit" do
  transaction = Transaction.new(params)
  transaction.update()
  redirect(to("/banked/transactions"))
end

post "/banked/transactions/:id/delete" do
  Transaction.delete(params[:id])
  redirect(to("/banked/transactions"))
end

post "/banked/transactions/filter_tag" do
  @transactions = Transaction.filter_tag(params[:id])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @tag = Tag.find(params[:id])
  erb(:"transactions/index_filter_tag")
end

post "/banked/transactions/filter_merchant" do
  @transactions = Transaction.filter_merchant(params[:id])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @merchant = Merchant.find(params[:id])
  erb(:"transactions/index_filter_merchant")
end

post "/banked/transactions/filter_date" do
  @transactions = Transaction.filter_date(params[:start_date], params[:end_date])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @start_date = params[:start_date]
  @end_date = params[:end_date]
  @start_date_formatted = Transaction.format_date(params[:start_date])
  @end_date_formatted = Transaction.format_date(params[:end_date])
  erb(:"transactions/index_filter_date")
end

post "/banked/transactions/filter_value" do
  @transactions = Transaction.all()
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:"transactions/index_filter_value")
end
