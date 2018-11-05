class Product < ApplicationRecord
	belongs_to :category
	paginates_per 50
	searchkick match: :word_start, searchable: [:name, :price, :description, :stock]
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.jpg"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
