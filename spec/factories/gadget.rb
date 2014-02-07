FactoryGirl.define do
	factory :gadget do
		sequence :name do |n|
			"gadget-#{n}"
		end
		association :user
	end

end