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
  if params[:merchant_id] == "new" || params[:tag_id] == "new"
    @description = params[:description]
    @value = params[:value]
    @spend_date = params[:spend_date]
    if params[:merchant_id] == "new" && params[:tag_id] == "new"
      erb(:"transactions/new_merchant_and_tag")
    elsif params[:merchant_id] == "new"
      @tag_id = params[:tag_id]
      erb(:"transactions/new_merchant")
    else
      @merchant_id = params[:merchant_id]
      erb(:"transactions/new_tag")
    end
  else
    transaction = Transaction.new(params)
    transaction.save()
    redirect(to("/banked/transactions"))
  end
end

post "/banked/transactions/new_merchant" do
  merchant = Merchant.new(params)
  merchants = Merchant.merchants()
  if merchants.include?(merchant.name)
    existing_merchant = Merchant.find_by_name(merchant.name)
    transaction = Transaction.new({
      "description" => params[:description],
      "value" => params[:value],
      "spend_date" => params[:spend_date],
      "merchant_id" => existing_merchant.id,
      "tag_id" => params[:tag_id]
    })
    transaction.save()
    redirect(to("/banked/transactions"))
  else
    merchant.save()
    transaction = Transaction.new({
      "description" => params[:description],
      "value" => params[:value],
      "spend_date" => params[:spend_date],
      "merchant_id" => merchant.id,
      "tag_id" => params[:tag_id]
    })
    transaction.save()
    redirect(to("/banked/transactions"))
  end
end

post "/banked/transactions/new_tag" do
  tag = Tag.new(params)
  tags = Tag.tags()
  if tags.include?(tag.name)
    existing_tag = Tag.find_by_name(tag.name)
    transaction = Transaction.new({
      "description" => params[:description],
      "value" => params[:value],
      "spend_date" => params[:spend_date],
      "merchant_id" => params[:merchant_id],
      "tag_id" => existing_tag.id
    })
    transaction.save()
    redirect(to("/banked/transactions"))
  else
    tag.save()
    transaction = Transaction.new({
      "description" => params[:description],
      "value" => params[:value],
      "spend_date" => params[:spend_date],
      "merchant_id" => params[:merchant_id],
      "tag_id" => tag.id
    })
    transaction.save()
    redirect(to("/banked/transactions"))
  end
end

post "/banked/transactions/new_merchant_and_tag" do
  merchant = Merchant.new({
    "name" => params[:name_m]
  })
  merchants = Merchant.merchants()
  tag = Tag.new({
    "name" => params[:name_t]
  })
  tags = Tag.tags()
  if tags.include?(tag.name) && merchants.include?(merchant.name)
    existing_tag = Tag.find_by_name(tag.name)
    existing_merchant = Merchant.find_by_name(merchant.name)
    transaction = Transaction.new({
      "description" => params[:description],
      "value" => params[:value],
      "spend_date" => params[:spend_date],
      "merchant_id" => existing_merchant.id,
      "tag_id" => existing_tag.id
    })
    transaction.save()
    redirect(to("/banked/transactions"))
  elsif tags.include?(tag.name) || merchants.include?(merchant.name)
    if tags.include?(tag.name)
      merchant.save()
      existing_tag = Tag.find_by_name(tag.name)
      transaction = Transaction.new({
        "description" => params[:description],
        "value" => params[:value],
        "spend_date" => params[:spend_date],
        "merchant_id" => params[:merchant_id],
        "tag_id" => existing_tag.id
      })
      transaction.save()
      redirect(to("/banked/transactions"))
    else
      tag.save()
      existing_merchant = Merchant.find_by_name(merchant.name)
      transaction = Transaction.new({
        "description" => params[:description],
        "value" => params[:value],
        "spend_date" => params[:spend_date],
        "merchant_id" => existing_merchant.id,
        "tag_id" => params[:tag_id]
      })
      transaction.save()
      redirect(to("/banked/transactions"))
    end
  else
    tag.save()
    merchant.save()
    transaction = Transaction.new({
      "description" => params[:description],
      "value" => params[:value],
      "spend_date" => params[:spend_date],
      "merchant_id" => merchant.id,
      "tag_id" => tag.id
    })
    transaction.save()
    redirect(to("/banked/transactions"))
  end
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
  @transactions = Transaction.filter_value(params[:operator], params[:value])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @operator_value = params[:operator]
  if @operator_value == "less"
    @operator_name = "Less than"
  else
    @operator_name = "Greater than"
  end
  @value = params[:value]
  erb(:"transactions/index_filter_value")
end
