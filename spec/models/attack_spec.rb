require 'spec_helper'

describe Attack do
  context "with 6 attackers and 3 defenders" do
    let(:attacker){
      mock alive?:                  true,
           active?:                 true,
           units_count:             7,
           neighbours_include?:     true,
           maximum_attackers_count: 6
    }
    
    let(:target){
      mock alive?:      true,
           active?:     true,
           units_count: 3
    }
    
    describe "#resolve!" do
      let(:attack){
        attack = Attack.new(attacker, target, 6)
        attack.resolve!
        attack
      }
      
      it "should have a winner" do
        attack.winner.should_not be_nil
      end
    end
  end
end
