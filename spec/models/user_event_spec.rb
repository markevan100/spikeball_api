require 'rails_helper'

RSpec.describe UserEvent, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:event_id) }
end
