class CreatePoliticians < ActiveRecord::Migration
  def self.up
    create_table :politicians do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :politicians
  end
end
