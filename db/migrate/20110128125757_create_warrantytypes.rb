class CreateWarrantytypes < ActiveRecord::Migration
  def self.up
    create_table :warrantytypes do |t|
      t.integer :WarrantyTypeId

      t.timestamps
    end
  end

  def self.down
    drop_table :warrantytypes
  end
end
