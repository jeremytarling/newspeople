# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def class_for_tag_cloud( current, min, max )
    current = current.to_f
    min = min.to_f
    max = max.to_f
    return 0 if min == max
    ( ( ( ( current - min ) / ( max - min ) ) ) *10 ).round
  end
end
