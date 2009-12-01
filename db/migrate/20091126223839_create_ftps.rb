class CreateFtps < ActiveRecord::Migration
  def self.up
    create_table :ftps do |t|
      t.string :host
      t.string :username
      t.string :crypted_password
      t.string :password_salt

      t.timestamps
    end
  end

  def self.down
    drop_table :ftps
  end
end
