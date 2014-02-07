class User < ActiveRecord::Base

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, confirmation: true
	validates :password_confirmation, presence: {if: :new_record?}
end