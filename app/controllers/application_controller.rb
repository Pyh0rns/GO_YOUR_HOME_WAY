class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_company
      dashboard_pro_path
    elsif current_user.properties.empty?
      new_property_path
    elsif current_user
      dashboard_path
    end
  end

end
