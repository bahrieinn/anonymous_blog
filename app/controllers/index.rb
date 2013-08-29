# GET ############################

get '/' do
  @posts = Post.order('created_at DESC')
  erb :index
end






# POST #############################


