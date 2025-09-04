class EnrollmentService
  include HTTParty
  base_uri ENV["BASE_URL"]
  headers "Accept" => "application/json", "apiKey" => "#{ENV["API_KEY"]}"

  def self.list_enrollments(course_id, query = {})
    get("/courses/#{course_id}/enrollments", query: query)
  end
end
