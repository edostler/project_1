require_relative("../models/tag")

get "/banked/tags" do
  @tags = Tag.all()
  erb(:"tags/index")
end

post "/banked/tags" do
  tag = Tag.new(params)
  tag.save()
  redirect(to("/banked/tags"))
end

get "/banked/tags/:id" do
  @tag = Tag.find(params[:id])
  erb(:"tags/show")
end

post "/banked/tags/:id/edit" do
  tag = Tag.new(params)
  tag.update()
  redirect(to("/banked/tags"))
end

post "/banked/tags/:id/delete" do
  Tag.delete(params[:id])
  redirect(to("/banked/tags"))
end
