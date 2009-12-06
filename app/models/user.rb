class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :sites
  has_many :servers
end
