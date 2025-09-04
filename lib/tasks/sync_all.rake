namespace :sync do
  desc "Sync users, courses, then enrollments"
  task all: :environment do
    puts "Syncing users..."
    UserBatchSyncJob.perform_now

    puts "Syncing courses..."
    CourseBatchSyncJob.perform_now

    puts "Syncing enrollments..."
    Course.pluck(:id).each do |course_id|
      CourseEnrollmentsSyncJob.perform_later(course_id)
    end
  end
end
