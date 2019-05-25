class Event < ApplicationRecord
  validates_presence_of :creator, :timing, :where
end
