class EnrollmentSyncJob < ApplicationJob
  queue_as :default

  def perform(enrollment)
    Enrollment.upsert({
      user_id: enrollment["user_id"],
      course_id: enrollment["course_id"],
      expires_at: enrollment["expires_at"],
      enrolled_at: enrollment["enrolled_at"],
      percent_complete: enrollment["percent_complete"]
    }, unique_by: :user_id)
  end
end
