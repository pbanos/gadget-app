require 'spec_helper'

describe Gadget do
	
	describe '#valid?' do
		let(:user){create(:user)}
		let(:another_user){create(:user)}
		let(:user_gadget){create(:gadget, user: user)}
		let(:another_user_gadget){create(:gadget, user: another_user)}
		let(:valid_attributes) do
			{
				user: user,
				name: 'My gadget'
			}
		end
		it "returns true with valid attributes" do
			expect(Gadget.new(valid_attributes)).to be_valid
		end
		it "returns false without a user" do
			expect(Gadget.new(valid_attributes.except(:user))).not_to be_valid
		end
		it "returns false without a name" do
			expect(Gadget.new(valid_attributes.except(:name))).not_to be_valid
		end
		it "returns false with a blank name" do
			expect(Gadget.new(valid_attributes.with(name: ''))).not_to be_valid
		end
		it "returns false with the name of a gadget belonging to the user" do
			expect(Gadget.new(valid_attributes.except(name: user_gadget.name))).not_to be_valid
		end
		it "returns true with the name of a gadget belonging to another user" do
			expect(Gadget.new(valid_attributes.except(name: another_user_gadget.name))).to be_valid
		end
	end
end