class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.integer :ContractId
      t.integer :ContractTypeId
      t.string :StartDate

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
