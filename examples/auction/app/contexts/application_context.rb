class ApplicationContext < Dicer::Context
  describe User do
    it_behaves_like Authenticatable

    role :guest do
      it_behaves_like Guest
    end
  end

  def logined?
    !current_user.guest?
  end

  def current_user
    @current_user ||= begin
      user = session[:user_id].present? ?
        User.where(id: session[:user_id].to_i).first :
        nil
      user ||= User.new.as(:guest)
    end
  end
end
