class CourseSyncJob < ApplicationJob
  queue_as :default

  def perform(course_id)
    course_data = CourseService.get_course(course_id)

    if course_data.success?
      Course.upsert({
        external_id: course_data["id"],
        name: course_data["name"],
        description: course_data["description"],
        heading: course_data["heading"],
        is_published: course_data["is_published"],
        image_url: course_data["image_url"]
      }, unique_by: :external_id)
    else
      Rails.logger.error("Failed to sync course with ID #{course_id}: #{course_data.code} - #{course_data.message}")
    end
  end
end
