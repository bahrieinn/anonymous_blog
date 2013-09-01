# GET ############################

# Show list of available tags
get '/tags' do
  if current_user
    @title = "Tags"
    @tags = Tag.order('name')
    erb :tag_list
  else
    redirect "/"
  end
end

get '/tags/:name' do
  if current_user
    @tag_name = params[:name]
    @title = @tag_name.capitalize
    if Tag.any? { |tag| tag.name == @tag_name }
      @posts = Post.joins(:tags).where('tags.name' => @tag_name).order('created_at DESC')
      erb :posts_by_tag
    else
      erb :error_no_tag
    end
  else
    redirect "/"
  end
end




# POST #############################
