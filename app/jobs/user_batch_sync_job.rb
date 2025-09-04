class UserBatchSyncJob < ApplicationJob
  queue_as :default

  def perform(user_ids = [])
    if user_ids.present?
      user_ids.each do |user_id|
        UserSyncJob.perform_later(user_id)
      end
    else
      # Sync all users in this job because all the required
      # attributes are already included on the index endpoint.
      # If more attributes are necessary in the future, we can change
      # it to enqueue a single user sync job for each user.

      page = 1

      loop do
        users = UserService.list_users(page: page)

        break if users["users"].empty?

        users["users"].each do |user|
          User.upsert({
            external_id: user["id"],
            email: user["email"],
            name: user["name"]
          }, unique_by: :external_id)
        end

        page += 1
      end
    end
  end
end
