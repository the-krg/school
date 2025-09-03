class User < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
