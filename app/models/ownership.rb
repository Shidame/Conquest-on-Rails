class Ownership < ActiveRecord::Base
  belongs_to :territory
  belongs_to :participation
  belongs_to :game
end
