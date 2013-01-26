class ItemDecorator < Draper::Base
  include Draper::LazyHelpers

  decorates :item

  def created_at
    distance_of_time_in_words(Time.now, source.created_at)
  end

  def description
    emojify(markdown(source.description))
  end
end
