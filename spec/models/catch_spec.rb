require 'rails_helper'

RSpec.describe Catch, type: :model do
  describe "relationships" do 
    it { should belong_to :user }
  end

  describe "validations" do 
    it { should validate_presence_of :species }
    it { should validate_presence_of :spot_name }
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
  end
end
