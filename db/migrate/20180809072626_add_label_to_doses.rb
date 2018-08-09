class AddLabelToDoses < ActiveRecord::Migration[5.2]
  def change
    add_column :doses, :label, :string
  end
end
