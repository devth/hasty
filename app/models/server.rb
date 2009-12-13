class Server < ActiveRecord::Base
  attr_encrypted :password, :key => '393b79433f616f445f652a752d', :attribute => 'crypted_password'
  
  belongs_to :user
  
  has_many :site_servers
  has_many :sites, :through => :site_servers
  
  validates_presence_of :url, :on => :create, :message => "URL is required."
  validates_presence_of :username, :on => :create, :message => "Username is required."
  validates_presence_of :password, :on => :create, :message => "Password is required."
  
  
  def name
    username + "@" + url
  end
  
  def to_s
    name
  end
  
end