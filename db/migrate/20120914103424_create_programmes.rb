class CreateProgrammes < ActiveRecord::Migration
  def self.up
    create_table :programmes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :programmes
  end
end
