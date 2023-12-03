require "rails_helper"

RSpec.describe CatchLure, type: :model do 
  describe "relationships" do 
    it { should belong_to :catch }
    it { should belong_to :lure }
  end

  describe "validations" do
    it { should validate_presence_of :catch_id }
    it { should validate_presence_of :lure_id }
  end
end