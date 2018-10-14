class Product < ApplicationRecord
	belongs_to :category
	paginates_per 50
end
