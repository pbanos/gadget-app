require 'spec_helper'

describe Gadget do

	let(:user){create(:user)}
	let(:another_user){create(:user)}
	
	describe '#valid?' do
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
			expect(Gadget.new(valid_attributes.with(name: user_gadget.name))).not_to be_valid
		end
		it "returns true with the name of a gadget belonging to another user" do
			expect(Gadget.new(valid_attributes.with(name: another_user_gadget.name))).to be_valid
		end
	end

	describe '.search' do
		let(:search_result) { described_class.search(user, query)}
		let(:query){'abc'}
		context "with a query contained in the name of more than one gadget belonging to the user" do
			let(:matching_user_gadgets) do
				[
					create(:gadget, name: "gadget#{query}1", user: user), 
					create(:gadget, name: "#{query}gadget", user: user), 
					create(:gadget, name: "gadget#{query}", user: user),
					create(:gadget, name: query, user: user),
				]
			end
			let(:non_matching_user_gadgets) do
				3.times.map do |i|
					create(:gadget, name: "gadget#{i}", user: user)
				end
			end
			let(:matching_another_user_gadgets) do
				3.times.map do |i|
					create(:gadget, name: "gadget#{query}#{i}", user: another_user)
				end
			end
			let(:non_matching_another_user_gadgets) do
				3.times.map do |i|
					create(:gadget, name: "gadget#{i}", user: another_user)
				end
			end
			before(:each) do
				matching_user_gadgets
				non_matching_user_gadgets
				matching_another_user_gadgets
				non_matching_another_user_gadgets
			end
			it "returns every gadget with a name containing the query belonging to the given user" do
				matching_user_gadgets.each do |gadget|
					expect(search_result).to include(gadget)
				end
			end
			it "returns no gadget with a name not containing the query belonging to the given user" do
				non_matching_user_gadgets.each do |gadget|
					expect(search_result).not_to include(gadget)
				end
			end
			it "returns every gadget with a name containing the query belonging to a user other than the given one" do
				matching_another_user_gadgets.each do |gadget|
					expect(search_result).not_to include(gadget)
				end
			end
			it "returns every gadget with a name not containing the query belonging to a user other than the given one" do
				non_matching_another_user_gadgets.each do |gadget|
					expect(search_result).not_to include(gadget)
				end
			end
		end
		context "with a query contained in the name of exactly one gadget belonging to the user" do
			let(:matching_user_gadget) do
				create(:gadget, name: "gadget#{query}", user: user)
			end
			let(:non_matching_user_gadgets) do
				3.times.map do |i|
					create(:gadget, name: "gadget#{i}", user: user)
				end
			end
			let(:matching_another_user_gadgets) do
				3.times.map do |i|
					create(:gadget, name: "gadget#{query}#{i}", user: another_user)
				end
			end
			let(:non_matching_another_user_gadgets) do
				3.times.map do |i|
					create(:gadget, name: "gadget#{i}", user: another_user)
				end
			end
			before(:each) do
				matching_user_gadget
				non_matching_user_gadgets
				matching_another_user_gadgets
				non_matching_another_user_gadgets
			end
			it "returns every gadget with a name containing the query belonging to the given user" do
				expect(search_result).to include(matching_user_gadget)
			end
			it "returns no gadget with a name not containing the query belonging to the given user" do
				non_matching_user_gadgets.each do |gadget|
					expect(search_result).not_to include(gadget)
				end
			end
			it "returns every gadget with a name containing the query belonging to a user other than the given one" do
				matching_another_user_gadgets.each do |gadget|
					expect(search_result).not_to include(gadget)
				end
			end
			it "returns every gadget with a name not containing the query belonging to a user other than the given one" do
				non_matching_another_user_gadgets.each do |gadget|
					expect(search_result).not_to include(gadget)
				end
			end
		end
		context "with a query not contained in the name of more than one gadget belonging to the user" do
			let(:non_matching_user_gadgets) do
				3.times.map do |i|
					create(:gadget, name: "gadget#{i}", user: user)
				end
			end
			let(:matching_another_user_gadgets) do
				3.times.map do |i|
					create(:gadget, name: "gadget#{query}#{i}", user: another_user)
				end
			end
			let(:non_matching_another_user_gadgets) do
				3.times.map do |i|
					create(:gadget, name: "gadget#{i}", user: another_user)
				end
			end
			before(:each) do
				non_matching_user_gadgets
				matching_another_user_gadgets
				non_matching_another_user_gadgets
			end
			it "returns an empty set" do
				expect(search_result).to be_empty
			end
		end
	end
end