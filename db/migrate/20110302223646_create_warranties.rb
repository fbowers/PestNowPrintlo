class CreateWarranties < ActiveRecord::Migration
  def self.up
    create_table :warranties do |t|
      t.string :WarrantyId

      t.timestamps
    end
  end

  def self.down
    drop_table :warranties
  end
end
