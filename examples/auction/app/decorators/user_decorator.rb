class UserDecorator < Draper::Base
  decorates :user

  def created_at
    %Q{<time datetime="#{
      source.created_at.to_s(:rfc822)
    }\">#{
      h.distance_of_time_in_words(Time.now, source.created_at)
    }</time>}.html_safe
  end
end
