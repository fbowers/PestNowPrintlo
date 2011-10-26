class CreateRusers < ActiveRecord::Migration
  def self.up
    create_table :rusers do |t|
      t.string :UserId
      t.string :login
      t.string :crypted_password

      t.timestamps
    end
  end

  def self.down
    drop_table :rusers
  end
end
