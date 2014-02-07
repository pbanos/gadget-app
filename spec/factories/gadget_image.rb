FactoryGirl.define do
	factory :gadget_image do
		attachment {File.new('spec/images/image-1.jpg')}
		association :gadget
	end

end