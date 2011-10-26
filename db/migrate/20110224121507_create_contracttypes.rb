class CreateContracttypes < ActiveRecord::Migration
  def self.up
    create_table :contracttypes do |t|
      t.integer :ContractTypeID
      t.string :Name

      t.timestamps
    end
  end

  def self.down
    drop_table :contracttypes
  end
end
