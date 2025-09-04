class UserService
  include HTTParty
  base_uri ENV["BASE_URL"]
  headers "Accept" => "application/json", "apiKey" => "#{ENV["API_KEY"]}"

  def self.list_users(query = {})
    get("/users", query: query)
  end

  def self.get_user(user_id)
    get("/users/#{user_id}")
  end
end
