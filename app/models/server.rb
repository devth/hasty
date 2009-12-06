# require 'attr_encrypted'

class Server < ActiveRecord::Base
  attr_encrypted :password, :key => '393b79433f616f445f652a752d', :attribute => 'crypted_password'
  
  has_many :site_servers
  has_many :sites, :through => :site_servers
end