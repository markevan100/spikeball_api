class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates_presence_of :user_id, :event_id
end
