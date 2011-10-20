class Territory < ActiveRecord::Base
  has_many :neighbourhoods
  has_many :neighbours, through: :neighbourhoods, source: :other_territory
end
