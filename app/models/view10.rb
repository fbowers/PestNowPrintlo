class View10 < ActiveRecord::Base
  set_table_name "View10"
  set_primary_key "PropertyId"

  has_many :Schedule_Routes, :primary_key => :ScheduleId, :foreign_key => :ScheduleId
    has_many :Routes, :through => :Schedule_Routes
  has_many :Contracts, :foreign_key => :PropertyId
has_many :Warranties, :foreign_key => :PropertyId
has_many :Histories, :foreign_key => :PropertyId
end
