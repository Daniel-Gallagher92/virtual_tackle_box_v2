require 'rails_helper'

RSpec.describe User, type: :model do

  describe "relationships" do 
    it { should have_many :lures }
    it { should have_many :catches }
  end

  describe "validations" do 
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end