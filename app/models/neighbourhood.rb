class Neighbourhood < ActiveRecord::Base
  belongs_to :territory
  belongs_to :other_territory, class_name: "Territory" 
end
