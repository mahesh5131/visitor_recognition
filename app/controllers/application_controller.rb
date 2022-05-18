class ApplicationController < ActionController::Base

  def after_sign_in_path(resource)
    visitors_path
  end
end
