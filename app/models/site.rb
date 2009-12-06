class Site < ActiveRecord::Base
  
  belongs_to :user
  
  has_many :site_servers
  has_many :servers, :through => :site_servers
  
  # accept_nested_attributes_for :servers, :allow_destroy => true
  
  
  #
  #
  # TODO: associate sites and servers with the USER!!
end
