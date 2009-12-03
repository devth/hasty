class CreateServers < ActiveRecord::Migration
  def self.up
    create_table :servers do |t|
      t.string :url
      t.string :username
      t.string :crypted_password
      t.integer :port

      t.timestamps
    end
  end

  def self.down
    drop_table :servers
  end
end
