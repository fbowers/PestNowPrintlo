class CreateWdireports < ActiveRecord::Migration
  def self.up
    create_table :wdireports do |t|
      t.string :WdiReportId

      t.timestamps
    end
  end

  def self.down
    drop_table :wdireports
  end
end
