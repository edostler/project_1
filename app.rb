require("sinatra")
require("sinatra/contrib/all")
require_relative("controllers/dashboard_controller")
require_relative("controllers/merchants_controller")
require_relative("controllers/tags_controller")
require_relative("controllers/transactions_controller")

get '/banked' do
  erb(:"dashboard/index")
end
