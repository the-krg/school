require 'rails_helper'

RSpec.describe EnrollmentSyncJob, type: :job do
  describe '#perform' do
    let(:user) { User.create!(id: 123, external_id: 000, name: "Test User", email: "test@example.com") }
    let(:course) { Course.create!(id: 456, external_id: 000, name: "Test Course", is_published: true) }
    let(:enrollment_data) { { "user_id" => user.id, "course_id" => course.id } }

    it 'syncs enrollment data' do
      expect {
        described_class.perform_now(enrollment_data)
      }.to change { Enrollment.count }.by(1)

      enrollment = Enrollment.last
      expect(enrollment.user_id).to eq(123)
      expect(enrollment.course_id).to eq(456)
    end
  end
end
