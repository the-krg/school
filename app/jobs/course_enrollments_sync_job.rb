class CourseEnrollmentsSyncJob < ApplicationJob
  queue_as :default

  def perform(course_id)
    course = Course.find(course_id)
    page = 1

    loop do
      enrollments = EnrollmentService.list_enrollments(course.external_id, { page: page })

      break if enrollments["enrollments"].empty?

      enrollments["enrollments"].each do |enrollment|
        user = User.find_by(external_id: enrollment["user_id"])

        if user.present?
          Enrollment.upsert({
            user_id: user.id,
            course_id: course.id,
            expires_at: enrollment["expires_at"],
            enrolled_at: enrollment["enrolled_at"],
            percent_complete: enrollment["percent_complete"]
          }, unique_by: [ :user_id, :course_id ])
        else
          UserSyncJob.perform_later(enrollment["user_id"])
        end
      end

      page += 1
    end
  end
end
