class SiteServer < ActiveRecord::Base
  belongs_to :site
  belongs_to :server
  
  has_one :user, :through => :site
end
