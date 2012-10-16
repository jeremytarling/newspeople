class Person < ActiveRecord::Base

  #added by JT as Rails was mooaning about undefined methods on class Person
  attr_accessor :name
  attr_accessor :description
  attr_accessor :dbpedia_uri
  attr_accessor :cooccurence_count
  attr_accessor :image_uri
  
  require 'open-uri'
  
  def url_key
    URI.escape(CGI.escape( self.dbpedia_uri.split( '/' ).last ),'.')
  end
  
  def image
    if self.image_uri
      self.image_uri
    else
      "http://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Question_mark_3d.png/310px-Question_mark_3d.png"
    end
  end
end
