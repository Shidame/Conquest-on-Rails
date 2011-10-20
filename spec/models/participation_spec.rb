require 'spec_helper'

describe Participation do
  let(:participation) { FactoryGirl.create(:participation_with_territories) }
  
  describe "#dispatch_remaining_units!" do
    before :each do
      @units_to_deploy_count = participation.units_count
      @deployed_units_count  = participation.ownerships.sum(:units_count)
      
      participation.dispatch_remaining_units!
    end
    
    
    it "should not have undeployed units" do
      participation.units_count.should == 0
    end
    
    
    it "should have the right number of units deployed" do
      expected_units_count = @units_to_deploy_count + @deployed_units_count
      actual_units_count   = participation.ownerships.sum(:units_count)
      
      actual_units_count.should == expected_units_count
    end
  end
end
