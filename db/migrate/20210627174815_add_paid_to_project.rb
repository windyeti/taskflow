class AddPaidToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :paid, :boolean, default: false
  end
end
