require 'spec_helper'

describe GadgetImage do
	let(:gadget){create(:gadget)}
	describe '#valid?' do
		let(:valid_attributes) do
			{
				gadget: gadget,
				attachment: File.new('spec/images/image-1.jpg')
			}
		end
		it "returns true given valid attributes" do
			expect(GadgetImage.new(valid_attributes)).to be_valid
		end
		it "returns false without a gadget" do
			expect(GadgetImage.new(valid_attributes.except(:gadget))).not_to be_valid
		end
		it "returns false without an attachment" do
			expect(GadgetImage.new(valid_attributes.except(:attachment))).not_to be_valid
		end
		it "returns false without an image-typed attachment" do
			expect(GadgetImage.new(valid_attributes.with(attachment: File.new('spec/images/non-image.txt')))).not_to be_valid
		end
	end
end