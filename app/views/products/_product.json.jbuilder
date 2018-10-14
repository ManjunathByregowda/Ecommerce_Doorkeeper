json.extract! product, :id, :name, :price, :description, :stock, :category_id, :cod_eligible, :release_datetime, :image_url, :created_at, :updated_at
json.url product_url(product, format: :json)
