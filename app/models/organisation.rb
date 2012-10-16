class Organisation < ActiveRecord::Base
  #added by JT as Rails was moaining about undef methods on objects
  attr_accessor :name
  attr_accessor :description
  attr_accessor :dbpedia_uri
  attr_accessor :cooccurence_count
  attr_accessor :image_uri

  require 'open-uri'

  def url_key
    URI.escape(CGI.escape( self.dbpedia_uri.split( '/' ).last ),'.')
  end
end
