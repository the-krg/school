API_KEY = "7JbSA3ep6XOMV3t8t7QXuXq9HS79Dwnr"
BASE_URL = "https://developers.teachable.com/v1/"

class CourseService
  include HTTParty
  base_uri BASE_URL
  headers "Accept" => "application/json", "apiKey" => "#{API_KEY}"

  def self.list_courses(query = {})
    get("/courses", query: query)
  end

  # Other actions like create, update, delete not implemented because they're not needed yet
end
