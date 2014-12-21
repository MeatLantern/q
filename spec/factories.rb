FactoryGirl.define do  factory :invitation_preference, :class => 'InvitationPreferences' do
    
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
