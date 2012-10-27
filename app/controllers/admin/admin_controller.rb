module Admin
  class AdminController < ActionController::Base
    protect_from_forgery

    layout 'admin'
    before_filter :authenticate_user!
  end
end
