class CourseService
  include HTTParty
  base_uri ENV["BASE_URL"]
  headers "Accept" => "application/json", "apiKey" => "#{ENV["API_KEY"]}"

  def self.list_courses(query = {})
    get("/courses", query: query)
  end

  # Other actions like create, update, delete not implemented because they're not needed yet
end
