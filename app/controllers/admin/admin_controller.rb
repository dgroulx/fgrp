module Admin
  class AdminController < ActionController::Base
    protect_from_forgery
#    check_authorization # cancan
    before_filter :authenticate_user! # devise
    layout 'admin'
  end
end
