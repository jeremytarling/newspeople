class Programme < ActiveRecord::Base
  #added by JT as Rails was moaining about undef methods on objects
  attr_accessor :pid
  attr_accessor :title
  attr_accessor :subtitle
  attr_accessor :synopsis
end
