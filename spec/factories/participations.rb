FactoryGirl.define do
  factory :participation do
  end
  
  factory :participation_with_territories, :parent => :participation do
    after_create do |participation, proxy|
      3.times do
        participation.ownerships << FactoryGirl.create(:ownership)
      end
    end
  end
end
