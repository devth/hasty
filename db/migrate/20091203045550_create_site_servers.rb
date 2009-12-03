class CreateSiteServers < ActiveRecord::Migration
  def self.up
    create_table :site_servers do |t|
      t.references :site
      t.references :server

      t.timestamps
    end
  end

  def self.down
    drop_table :site_servers
  end
end
