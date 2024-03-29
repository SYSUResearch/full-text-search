class ApplicationController < ActionController::Base  
  protect_from_forgery
  helper :all
  helper_method :current_user_session, :current_user, :auth_provider, :is_user_login, :totalclaimed, :total_found_amount
  
  def totalclaimed
    ClaimAmount.where(:user_id => current_user.id).sum(:amount)
  end
  
  def total_found_amount
    ClaimAmount.where(:tracker_user_id => current_user.id).sum(:amount)
  end
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def is_user_login
    return (current_user ? true : false )
  end
  
  def auth_provider
    return @auth_provider if defined?(@auth_provider)
    @auth_provider = current_user.authorization.find_by_login(true)
  end
    
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_path
      return false
    end
  end
    
  def store_location(location = nil)
    session[:return_to] = request.request_uri||location
  end
    
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
