module PersonHelper
  
  def person_image( person )
    image_tag( 
      person.image,
      :alt => person.name, 
      :title => person.name, 
      :height => 100, 
      :width => 100
    )
  end
end
