require 'spec_helper'

describe Game do
  context "#start!" do
    before :all do
      @game   = FactoryGirl.create :game
      alpha   = FactoryGirl.create :alpha
      beta    = FactoryGirl.create :beta
      gamma   = FactoryGirl.create :gamma
      epsilon = FactoryGirl.create :epsilon
      delta   = FactoryGirl.create :delta
      
      @game.add!(alpha)
      @game.add!(beta)
      @game.add!(gamma)
      @game.add!(epsilon)
      @game.add!(delta)
    end
    
    
    it "should not remain units to participants"
    it "should have at least one unit on each territory"
    it "should have 25 units on the pool of territories of each participant"
    it "should be alpha who plays first"
  end
end
