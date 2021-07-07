class Project < ApplicationRecord
  belongs_to :user
  belongs_to :status

  has_many :project_typejobs, dependent: :destroy
  has_many :typejobs, through: :project_typejobs

  validates :title, presence: true

  scope :actual, -> { where.not(status: Status.find(4)) }
  scope :archive, -> { rewhere(status: Status.find(4)) }
  scope :sum_done, -> { where(paid: false).where(status: Status.find(3)).sum(:cost) }
end
