# GET ############################
enable :sessions

get '/users/login' do
  puts params[:user]['email']
  @user = User.find_by_email(params[:user]['email'])
  
  if @user.authenticate(params[:user]['password'])
    session[:user_id] = @user.id
    redirect "/posts"
  else
    redirect "/"
  end
end

get '/users/logout' do
  session.clear
  redirect "/"
end


# POST #############################

post '/users/new' do
  @user = User.new(params[:user])

  if @user.save
    redirect "/posts"
  else
    redirect "/"
  end
end