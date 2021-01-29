class Typejob < ApplicationRecord
  has_many :project_typejobs, dependent: :destroy
  has_many :projects, through: :project_typejobs

  validates :name, presence: true

  def just_name
    name
  end
end
