require 'bcrypt'

class SessionsController < ApplicationController
  def login
  end
  def face
  end
  def trangchinh
    firebase = FirebaseService.new
    @user = session[:user]
    # Lấy thông tin người dùng từ session
    user_id = session[:user_id]
    @user = firebase.find_user_by_id(user_id)
  
    unless @user
      redirect_to login_path, alert: "Bạn cần đăng nhập để truy cập trang này."
    end
  end
  def destroy
    # Clear the session
    session.clear
  end
  def create
    # Khởi tạo dịch vụ Firebase
    firebase = FirebaseService.new
    
    # Tìm kiếm người dùng theo email được cung cấp trong params
    user = firebase.find_user_by_email(params[:email])
  
    # Kiểm tra xem người dùng có tồn tại hay không
    if user
      # Lấy dữ liệu người dùng từ phản hồi của Firebase
      user_data = user[:data]
  
      # So sánh mật khẩu nhập vào với mật khẩu lưu trữ trong cơ sở dữ liệu
      if params[:password] == user_data["password"]
        # Nếu mật khẩu đúng, lưu ID người dùng vào session
        session[:user_id] = user_data["id"]
        # Trả về phản hồi thành công
        render json: { success: true, message: 'Đăng nhập thành công.' }
      else
        # Nếu mật khẩu sai, trả về thông báo lỗi
        render json: { success: false, message: 'Mật khẩu không chính xác.' }, status: :unprocessable_entity
      end
    else
      # Nếu không tìm thấy người dùng, trả về thông báo lỗi
      render json: { success: false, message: 'Email không tồn tại.' }, status: :unprocessable_entity
    end
  end
  

  def show
    firebase = FirebaseService.new
  
    # Lấy thông tin người dùng từ session
    user_id = session[:user_id]
    @user = firebase.find_user_by_id(user_id)
  
    unless @user
      redirect_to login_path, alert: "Bạn cần đăng nhập để truy cập trang này."
    end
  end
  def destroy
    Rails.logger.debug("Logging out user ID: #{session[:user_id]}") # Debugging log
    session[:user_id] = nil
    redirect_to login_path, notice: 'Đã đăng xuất.'
  end
end

