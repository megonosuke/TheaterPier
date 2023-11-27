class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?



protected

  def configure_permitted_parameters
    added_attrs = [ :avatar, :name, :email, :password, :password_confirmation, :current_password ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end


  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope == :user
        posts_path
    elsif resource_or_scope == :admin
        admin_users_path
    else
        posts_path
    end
  end
  
  

private
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
        posts_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        posts_path
    end
  end
end
