module ApplicationHelper
  def emojify(content)
    h(content).to_str.gsub(/:(?<emoji>[a-z0-9\+\-_]+):/) do |match|
      emoji = $~[:emoji]
      if Emoji.names.include?(emoji)
        image_tag("emoji/#{emoji}.png", alt: emoji, class: 'emoji')
      else
        match
      end
    end.html_safe if content.present?
  end

  def markdown(content)
    GitHub::Markdown.render_gfm(content).html_safe
  end
end
