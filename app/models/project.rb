class Project < ApplicationRecord
  belongs_to :user
  belongs_to :status

  has_many :project_typejobs, dependent: :destroy
  has_many :typejobs, through: :project_typejobs

  validates :title, presence: true
end
