# GET ############################

get '/' do
  unless current_user
    @title = "Login"          
    erb :index, :layout => false
  else
    redirect "/posts"
  end
end




# POST #############################

