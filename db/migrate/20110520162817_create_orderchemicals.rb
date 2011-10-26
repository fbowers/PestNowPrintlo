class CreateOrderchemicals < ActiveRecord::Migration
  def self.up
    create_table :orderchemicals do |t|
      t.int :OrderId
      t.int :chemical_id
      t.int :quantity
      t.int :cart_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orderchemicals
  end
end
