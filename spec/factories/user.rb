FactoryGirl.define do
	factory :user do
		sequence :username do |n|
			"user#{n}"
		end
		password 'SomePassword.123'
		password_confirmation { password }
	end

end