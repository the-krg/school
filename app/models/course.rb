class Course < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  validates :course_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :heading, presence: true
  validates :is_published, inclusion: { in: %w[true false] }
end
