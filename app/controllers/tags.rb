# GET ############################

# Show list of available tags
get '/tags' do
  @tags = Tag.order('name')
  erb :tag_list
end

get '/tags/:name' do
  @tag_name = params[:name]
  @posts = Post.joins(:tags).where('tags.name' => @tag_name).order('created_at DESC')
  erb :posts_by_tag
end




# POST #############################
