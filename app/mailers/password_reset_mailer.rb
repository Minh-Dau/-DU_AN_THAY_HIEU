class PasswordResetMailer < ApplicationMailer
  def send_verification_code(email, verification_code)
    @verification_code = verification_code
    @user_email = email
    mail(to: @user_email, subject: 'Mã xác thực khôi phục mật khẩu')
  end
end
 