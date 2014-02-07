class User < ActiveRecord::Base

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, confirmation: true
	validates :password_confirmation, presence: {if: :new_record?}

	devise :database_authenticatable, :registerable, :validatable

	def email_required?
		false
	end

	def email_changed?
		false
	end
end