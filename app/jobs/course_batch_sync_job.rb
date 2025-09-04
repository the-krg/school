class CourseBatchSyncJob < ApplicationJob
  queue_as :default

  def perform
    page = 1

    loop do
      courses = CourseService.list_courses(page: page)

      break if courses["courses"].empty?

      courses["courses"].each do |course|
        Course.upsert({
          external_id: course["id"],
          name: course["name"],
          heading: course["heading"],
          description: course["description"],
          is_published: course["is_published"],
          image_url: course["image_url"]
        }, unique_by: :external_id)
      end

      page += 1
    end
  end
end
