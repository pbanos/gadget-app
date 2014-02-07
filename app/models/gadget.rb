class Gadget < ActiveRecord::Base

	belongs_to :user

	validates :name, presence: true, uniqueness: {scope: :user_id}
	validates :user_id, presence: true

	def self.search(user, query)
		where("user_id = ? AND name LIKE ?", user.id, "%#{query}%")
	end
end