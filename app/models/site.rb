class Site < ActiveRecord::Base
  
  belongs_to :user
  
  has_many :site_servers
  has_many :servers, :through => :site_servers
  
  accepts_nested_attributes_for :site_servers, :allow_destroy => true
  
  
  # def server_id
  #   servers[0].id if servers[0]
  # end
  
  # for version 1.0 use a helper to make a site act like it only has one server
  # def server
  #     servers[0]
  #   end
  #   def server(server)
  #     servers[0] = server
  #   end
  
  
  #
  #
  # TODO: associate sites and servers with the USER!!
end
