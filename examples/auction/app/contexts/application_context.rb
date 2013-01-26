class ApplicationContext < Dicer::Context
  describe User do
    it_behaves_like Authenticatable
  end

  def logined?
    current_user.present?
  end

  def current_user
    return @current_user if instance_variable_defined?(:@current_user)

    @current_user ||= session[:user_id].present? ?
      User.where(id: session[:user_id].to_i).first :
      nil
  end
end
