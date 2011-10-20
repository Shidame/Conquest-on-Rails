FactoryGirl.define do
  factory :user do
    name                  "default"
    email                 { "#{name}@conquest-on-rails.org".downcase }
    password              { name.downcase }
    password_confirmation { name.downcase }
  end
  
  factory :alpha, parent: :user, class: User do
    name "Alpha"
  end
  
  factory :beta, parent: :user, class: User do
    name "Beta"
  end
  
  factory :gamma, parent: :user, class: User do
    name "Gamma"
  end
  
  factory :delta, parent: :user, class: User do
    name "Delta"
  end
  
  factory :epsilon, parent: :user, class: User do
    name "Epsilon"
  end
end
