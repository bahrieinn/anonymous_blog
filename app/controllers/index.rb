# GET ############################

get '/' do
  @title = "Home"
  @posts = Post.order('created_at DESC')
  erb :index
end






# POST #############################


