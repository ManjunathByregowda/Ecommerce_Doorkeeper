class AddAvatarColumnToProducts < ActiveRecord::Migration[5.2]
  def up
    add_attachment :products, :avatar
  end

  def down
    remove_attachment :products, :avatar
  end
end
