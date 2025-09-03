class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :course_id
      t.datetime :enrolled_at
      t.datetime :expires_at
      t.datetime :completed_at
      t.integer :percent_complete, default: 0

      t.timestamps
    end
  end
end
