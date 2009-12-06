class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name
      t.string :url
      t.string :path
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
