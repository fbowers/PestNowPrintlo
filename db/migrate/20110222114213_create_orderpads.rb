class CreateOrderpads < ActiveRecord::Migration
  def self.up
    create_table :orderpads do |t|
      t.integer :OrderId
      t.integer :BranchId

      t.timestamps
    end
  end

  def self.down
    drop_table :orderpads
  end
end
