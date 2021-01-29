class CreateProjectTypejobs < ActiveRecord::Migration[5.2]
  def change
    create_table :project_typejobs do |t|
      t.references :project, foreign_key: true
      t.references :typejob, foreign_key: true

      t.timestamps
    end
  end
end
