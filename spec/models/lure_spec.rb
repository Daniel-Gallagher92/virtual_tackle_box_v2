require 'rails_helper'

RSpec.describe Lure, type: :model do
  describe "relationships" do 
    it { should belong_to :user}
    it { should have_many :catch_lures }
    it { should have_many(:catches).through(:catch_lures) }
  end

  describe "validations" do 
    it { should validate_presence_of :brand }
    it { should validate_presence_of :variety }
    it { should validate_presence_of :color }
    it { should validate_presence_of :weight }
  end
end
