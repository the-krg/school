class UserSyncJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user_data = UserService.get_user(user_id)

    if user_data.success?
      User.upsert({
        external_id: user_data["id"],
        name: user_data["name"],
        email: user_data["email"]
      }, unique_by: :external_id)
    else
      Rails.logger.error("Failed to sync user with ID #{user_id}: #{user_data.code} - #{user_data.message}")
    end
  end
end
