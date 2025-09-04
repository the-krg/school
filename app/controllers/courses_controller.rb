class CoursesController < ApplicationController
  def index
    @courses = Course.where(is_published: true).includes(enrollments: :user)
  end
end
