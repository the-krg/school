class User < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  validates :external_id, presence: true, uniqueness: true
end
