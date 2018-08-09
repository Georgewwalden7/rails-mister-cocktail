class AddSpecialsToCocktail < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :tags, :string, array: true, :default => []
  end
end
