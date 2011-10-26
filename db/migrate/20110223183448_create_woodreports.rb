class CreateWoodreports < ActiveRecord::Migration
  def self.up
    create_table :woodreports do |t|
      t.integer :WDIId
      t.string :StructureType
      t.string :NoVisible

      t.timestamps
    end
  end

  def self.down
    drop_table :woodreports
  end
end
