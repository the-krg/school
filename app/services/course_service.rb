class CourseService
  include HTTParty
  base_uri ENV["BASE_URL"]
  headers "Accept" => "application/json", "apiKey" => "#{ENV["API_KEY"]}"

  def self.list_courses(query = {})
    get("/courses", query: query)
  end

  def self.get_course(course_id)
    get("/courses/#{course_id}")
  end
end
