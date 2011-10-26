class CreateBranches < ActiveRecord::Migration
  def self.up
    create_table :branches do |t|
      t.integer :BranchId

      t.timestamps
    end
  end

  def self.down
    drop_table :branches
  end
end
