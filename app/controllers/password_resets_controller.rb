class PasswordResetsController < ApplicationController
  # Bỏ qua xác thực CSRF cho các hành động này, vì chúng được gọi từ API
  skip_before_action :verify_authenticity_token


  # Lưu mã xác nhận tạm thời trong bộ nhớ. 
  # Trong thực tế, bạn nên lưu mã này vào database hoặc Redis để bảo mật và có thể quản lý tốt hơn.
  @@verification_codes = {}

  # Hành động gửi mã xác nhận đến email của người dùng
  def send_verification_code
    firebase = FirebaseService.new
    # Tìm kiếm người dùng theo địa chỉ email được gửi từ yêu cầu
    user = firebase.find_user_by_email(params[:email])
    
    if user
      # Tạo mã xác thực ngẫu nhiên (mã hex với chiều dài 6 ký tự)
      verification_code = SecureRandom.hex(3)
      
      # Gửi mã xác thực đến email của người dùng
      PasswordResetMailer.send_verification_code(user[:data]["email"], verification_code).deliver_now
      
      # Lưu mã xác thực vào @@verification_codes để có thể xác thực sau này
      @@verification_codes ||= {}
      @@verification_codes[user[:data]["email"]] = verification_code
      
      # Trả về phản hồi cho người dùng xác nhận rằng mã đã được gửi
      render json: { message: 'Mã xác nhận đã được gửi đến email của bạn!' }
    else
      # Nếu không tìm thấy người dùng với email này, trả về lỗi
      render json: { error: 'Không tìm thấy email này.' }, status: :not_found
      Rails.logger.info("Không tìm thấy người dùng với email: #{params[:email]}")
    end
  end
  
  
  # Hành động xác thực mã xác nhận
  def verify_code
    # Lấy email và mã từ yêu cầu
    email = params[:email]
    code = params[:code]

    # Kiểm tra xem mã xác thực có khớp với mã đã lưu hay không
    if @@verification_codes[email] == code
      # Nếu mã khớp, xóa mã khỏi bộ nhớ để tránh sử dụng lại
      @@verification_codes.delete(email)
      
      # Trả về phản hồi thành công
      render json: { success: true }, status: :ok
    else
      # Nếu mã không khớp, trả về thông báo lỗi
      render json: { success: false, message: 'Mã xác nhận không đúng!' }, status: :bad_request
    end
  end
end
