class ShoppingcartController < ApplicationController
  def giohang
    firebase = FirebaseService.new
    @user = session[:user]
    # Lấy thông tin người dùng từ session
    user_id = session[:user_id]
    @user = firebase.find_user_by_id(user_id)
  
    unless @user
      redirect_to login_path, alert: "Bạn cần đăng nhập để truy cập trang này."
    end
  end
end
