require 'rails_helper'

RSpec.describe Lure, type: :model do
  describe "relationships" do 
    it { should belong_to :user}
  end

  describe "validations" do 
    it { should validate_presence_of :brand }
    it { should validate_presence_of :variety }
    it { should validate_presence_of :color }
    it { should validate_presence_of :weight }
  end
end
