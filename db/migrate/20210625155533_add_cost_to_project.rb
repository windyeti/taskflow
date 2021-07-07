class AddCostToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :cost, :integer, default: 0
  end
end
