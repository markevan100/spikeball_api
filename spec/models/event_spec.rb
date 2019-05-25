require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:creator) }
  it { should validate_presence_of(:timing) }
  it { should validate_presence_of(:where) }
end
