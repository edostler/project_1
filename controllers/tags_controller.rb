require_relative("../models/tag")

get "/banked/tags" do
  @tags = Tag.all()
  erb(:"tags/index")
end

post "/banked/tags" do
  tag = Tag.new(params)
  tags = Tag.tags()
  if tags.include?(tag.name)
    redirect(to("/banked/tags"))
  else
    tag.save()
    redirect(to("/banked/tags"))
  end
end

get "/banked/tags/:id" do
  @tag = Tag.find(params[:id])
  erb(:"tags/show")
end

post "/banked/tags/:id/edit" do
  tag = Tag.new(params)
  tags = Tag.tags()
  if tags.include?(tag.name)
    redirect(to("/banked/tags"))
  else
    tag.update()
    redirect(to("/banked/tags"))
  end
end

post "/banked/tags/:id/delete" do
  Tag.delete(params[:id])
  redirect(to("/banked/tags"))
end

post "/banked/tags/filter_value" do
  @tags = Tag.all()
  @operator_value = params[:operator]
  if @operator_value == "less"
    @operator_name = "Less than"
  else
    @operator_name = "Greater than"
  end
  @value = params[:value]
  erb(:"tags/index_filter_value")
end
