class SiteServer < ActiveRecord::Base
  belongs_to :site
  belongs_to :server
end
