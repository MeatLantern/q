FactoryGirl.define do  factory :message do
    
  end
  factory :suggestion do
    
  end
  factory :comment do
    
  end
  factory :report do
    
  end
  factory :invitation_preference, :class => 'InvitationPreferences' do
    
  end
  factory :transformation do
    
  end

  factory :user do |f|
    f.username "test1"
    f.email "test1@test.com"
    f.password "test1test1"
    f.password_confirmation "test1test1"
  end
end
