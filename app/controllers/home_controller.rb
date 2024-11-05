class HomeController < ApplicationController
  def register
    # Renders the registration form
  end

  def create
    firebase_service = FirebaseService.new
    email = params[:email]

    # Check if the email is already registered
    begin
      existing_user = firebase_service.find_user_by_email(email)
      if existing_user
        render json: { success: false, message: "Email đã được đăng ký. Vui lòng sử dụng email khác." }, status: :unprocessable_entity
        return
      end
    rescue => e
      render json: { success: false, message: "Lỗi kiểm tra email: #{e.message}" }, status: :unprocessable_entity
      return
    end
    
    user_data = {
      id: (SecureRandom.random_number(90_000_000) + 10_000_000).to_s,
      username: params[:username],
      sodienthoai: params[:sodienthoai],
      email: params[:email],
      mat_khau: BCrypt::Password.create(params[:password]),
      dia_chi: params[:dia_chi] || "123 Main St",
      anh_dai_dien: params[:anh_dai_dien] || "link_to_image",
      key_ma_hoa: "encryptionKey123",
      ngay_tao: Time.now.utc.iso8601,
      trang_thai: true,
      ngay_cap_nhat: Time.now.utc.iso8601,
      role: params[:role] || "user"
    }


    begin
      result = firebase_service.create_user(user_data)
      if result.success?
        render json: { success: true, message: "Đăng ký thành công!" }
      else
        render json: { success: false, message: "Đăng ký không thành công. Vui lòng thử lại." }, status: :unprocessable_entity
      end
    rescue => e
      render json: { success: false, message: "Có lỗi xảy ra: #{e.message}" }, status: :unprocessable_entity
    end
  end
end
