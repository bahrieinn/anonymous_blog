# GET ############################
enable :sessions


# When you try '/posts', display index page
get '/posts' do
  if current_user 
    @user = User.find(session[:user_id])
    # @user = User.find(session[:user_id])
    @title = "Home"
    @posts = Post.order('created_at DESC') 
    erb :home
  else
    redirect "/"
  end
end


#GET a new post form
get '/posts/new' do
  if current_user
    @title = "New Post"
    erb :new
  else
    redirect "/"
  end
end

get '/posts/user/:username' do
  if current_user
    @posts = Post.where(author: params[:username])
    erb :_post_list
  else
    redirect "/"
  end
end

#GET a specific post
get '/posts/:id' do
  if current_user
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      erb :error_no_post
    else
      @title = @post.title
      erb :show 
    end
  else
    redirect "/"
  end
end


#GET an existing post in edit form
get '/posts/:id/edit' do
  if current_user
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      erb :error_no_post
    else
      if current_user.id == @post.user_id
        @title = "Edit"
        erb :edit
      else
        redirect "/posts/#{params[:id]}"
      end
    end
  else 
    redirect "/"
  end
end


# POST #############################

#CREATING new post
post '/posts' do
  if current_user
    tags = params[:tags].split(',').collect(&:strip)

    if params[:anonymous]
      tags.unshift('anonymous')
      @post = Post.new(params[:post])
    else
      @post = current_user.posts.new(params[:post])
      @post.author = current_user.username
    end

    if @post.save
      @post.add_tags(tags)
      redirect "/posts"
    else
      erb :new
    end

  else
    redirect "/"
  end
end


#UPDATING an existing post
post '/posts/:id' do
  if current_user
    #update post data
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    
    #update tag data
    tags = params[:tags].split(',').collect(&:strip)
    @post.tags.clear
    @post.add_tags(tags)

    redirect "/posts/#{@post.id}"
  else 
    redirect "/"
  end
end

post '/posts/:id/delete' do
  if current_user
    @post = Post.find(params[:id])
    @post.destroy
    redirect "/posts"
  else
    redirect "/"
  end
end









