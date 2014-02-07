require 'spec_helper'

describe User do
	
	describe '#valid?' do
		let(:valid_attributes) do
			{
				username: username,
				password: password,
				password_confirmation: password_confirmation
			}
		end
		let(:username){'pbanos'}
		let(:password){'Secret.123'}
		let(:password_confirmation){password}
		let(:existing_user){create(:user)}
		context "for a non-persisted user" do
			context "with a password confirmation" do
				let(:given_attributes){valid_attributes}
				it "returns true given valid username and password" do
					expect(User.new(given_attributes)).to be_valid
				end
				it "returns false without a username" do
					expect(User.new(given_attributes.except(:username))).not_to be_valid
				end
				it "returns false with the username of an existing user" do
					expect(User.new(given_attributes.with(username: existing_user.username))).not_to be_valid
				end
				it "returns false with a nil username" do
					expect(User.new(given_attributes.with(username: nil))).not_to be_valid
				end
				it "returns false with a blank username" do
					expect(User.new(given_attributes.with(username: ''))).not_to be_valid
				end
				it "returns false with a nil password" do
					expect(User.new(given_attributes.with(password: nil))).not_to be_valid
				end
				it "returns false with a blank password" do
					expect(User.new(given_attributes.with(password: ''))).not_to be_valid
				end
				it "returns false with a non-matching password confirmation" do
					expect(User.new(given_attributes.with(password_confirmation: 'another password'))).not_to be_valid
				end
			end
			context "without a password confirmation" do
				let(:given_attributes){valid_attributes.except(:password_confirmation)}
				it "returns false given valid username and password" do
					expect(User.new(given_attributes)).not_to be_valid
				end
				it "returns false without a username" do
					expect(User.new(given_attributes.except(:username))).not_to be_valid
				end
				it "returns false with a nil username" do
					expect(User.new(given_attributes.with(username: nil))).not_to be_valid
				end
				it "returns false with a blank username" do
					expect(User.new(given_attributes.with(username: ''))).not_to be_valid
				end
				it "returns false with the username of an existing user" do
					expect(User.new(given_attributes.with(username: existing_user.username))).not_to be_valid
				end
				it "returns false with a nil password" do
					expect(User.new(given_attributes.with(password: nil))).not_to be_valid
				end
				it "returns false with a blank password" do
					expect(User.new(given_attributes.with(password: ''))).not_to be_valid
				end
			end
		end
	end
end