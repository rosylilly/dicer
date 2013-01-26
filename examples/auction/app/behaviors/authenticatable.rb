module Authenticatable
  include Dicer::Behavior

  def guest?
    false
  end
end
