class UserDecorator < Draper::Base
  decorates :user

  def created_at
    %Q{<time datetime="#{source.created_at.to_s(:rfc822)}\">#{source.created_at.to_s(:relative)}</time>}.html_safe
  end
end
