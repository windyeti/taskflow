class AddStatusToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :status, foreign_key: true
  end
end
