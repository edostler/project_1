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
