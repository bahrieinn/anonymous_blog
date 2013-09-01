def current_user
  # Use find_by_id to get nil instead of an error if user doesn't exist
  @current_user ||= session[:user_id] && User.find_by_id(session[:user_id]) 
end