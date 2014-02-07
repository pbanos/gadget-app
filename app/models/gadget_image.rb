class GadgetImage < ActiveRecord::Base

	belongs_to :gadget

	has_attached_file :attachment, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	
	validates :gadget_id, presence: true
	validates_attachment :attachment, presence: true, content_type: { content_type: /\Aimage\/.*\Z/ }


end