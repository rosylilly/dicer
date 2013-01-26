Time::DATE_FORMATS[:relative] = ->(time) {
  diff = Time.now - time

  direction = diff > 0 ? 'ago' : 'since'

  case diff
  when 0
    'now'
  when 1.second .. (1.minute - 1.second)
    "#{diff} #{'seconds'.pluralize(diff)} #{direction}"
  when 1.minute .. (1.hour - 1.second)
    diff = (diff / 1.minute).floor
    "#{diff} #{'minutes'.pluralize(diff)} #{direction}"
  when 1.hour .. (1.day - 1.second)
    diff = (diff / 1.hour).floor
    "#{diff} #{'hours'.pluralize(diff)} #{direction}"
  else
    diff = (diff / 1.day).floor
    "#{diff} #{'days'.pluralize(diff)} #{direction}"
  end
}
