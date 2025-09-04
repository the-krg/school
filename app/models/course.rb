class Course < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  validates :external_id, presence: true, uniqueness: true
  validates :is_published, inclusion: { in: [ true, false ] }
end
