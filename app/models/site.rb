class Site < ActiveRecord::Base
  has_many :site_servers
  has_many :servers, :through => :site_servers
end
