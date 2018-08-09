class AddPrepationToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :preparation, :string
  end
end
