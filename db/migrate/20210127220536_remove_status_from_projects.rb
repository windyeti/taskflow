class RemoveStatusFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :status, :string
  end
end
