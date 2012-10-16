class Article < ActiveRecord::Base
  #added by JT as Rails was moaining about undef methods on objects
  attr_accessor :cps_id
  attr_accessor :headline
  attr_accessor :uri
  attr_accessor :published_at
end
