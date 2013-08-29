# GET ############################

# When you try /posts, display index page
get '/posts' do 
  erb :index
end


#GET a new post form
get '/posts/new' do
  erb :new
end

#GET a specific post
get '/posts/:id' do
  @post = Post.find_all_by_id(params[:id])
  if @post.empty?
    redirect "/" #come back later to add 'cant find specified blog'
  else
    erb :show 
  end
end


#GET an existing post in edit form
get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  if @post
    erb :edit
  else
    redirect "/" #come back later to add 'cant find specified blog'
  end
end


# POST #############################

#POST to here when creating NEW post
post '/posts' do
  @post = Post.new(params[:post])
  tags = params[:tags].split(',').collect(&:strip)

  if @post.save
    @post.add_tags(tags)
    redirect "/"
  else
    erb :new
  end
end


#POST here for UPDATING an existing post
post '/posts/:id' do
  #update post data
  @post = Post.find(params[:id])
  @post.update_attributes(params[:post])
  
  #update tag data
  tags = params[:tags].split(',').collect(&:strip)
  @post.add_tags(tags)

  redirect "/posts/#{@post.id}"
end

post '/posts/:id/delete' do
  @post = Post.find(params[:id])
  @post.destroy
  redirect "/"
end









