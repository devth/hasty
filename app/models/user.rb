class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :sites
  has_many :servers
  
  has_many :site_servers, :through => :sites
  
  
end
