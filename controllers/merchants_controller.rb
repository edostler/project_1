require_relative("../models/merchant")

get "/banked/merchants" do
  @merchants = Merchant.all()
  erb(:"merchants/index")
end

post "/banked/merchants" do
  merchant = Merchant.new(params)
  merchants = Merchant.merchants()
  if merchants.include?(merchant.name)
    redirect(to("/banked/merchants"))
  else
    merchant.save()
    redirect(to("/banked/merchants"))
  end
end

get "/banked/merchants/:id" do
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/show")
end

post "/banked/merchants/:id/edit" do
  merchant = Merchant.new(params)
  merchants = Merchant.merchants()
  if merchants.include?(merchant.name)
    redirect(to("/banked/merchants"))
  else
    merchant.update()
    redirect(to("/banked/merchants"))
  end
end

post "/banked/merchants/:id/delete" do
  Merchant.delete(params[:id])
  redirect(to("/banked/merchants"))
end

post "/banked/merchants/filter_value" do
  @merchants = Merchant.all()
  @operator_value = params[:operator]
  if @operator_value == "less"
    @operator_name = "Less than"
  else
    @operator_name = "Greater than"
  end
  @value = params[:value]
  erb(:"merchants/index_filter_value")
end
