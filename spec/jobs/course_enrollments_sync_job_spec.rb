require 'rails_helper'

RSpec.describe CourseEnrollmentsSyncJob, type: :job do
  describe '#perform' do
    context 'when course_id is provided' do
      let!(:course) { Course.create!(id: 456, external_id: 456, name: "Test Course", is_published: true) }

      context 'when user exists' do
        let!(:user) { User.create!(id: 123, external_id: 123, name: "Test User", email: "test@example.com") }
        let(:enrollments_data) { { user_id: 123, course_id: 456 }.with_indifferent_access }

        it 'syncs course data' do
          allow(EnrollmentService).to receive(:list_enrollments).with(456, { page: 1 }).and_return({ "enrollments" => [ enrollments_data ] })
          allow(EnrollmentService).to receive(:list_enrollments).with(456, { page: 2 }).and_return({ "enrollments" => [] })

          expect {
            described_class.perform_now(456)
          }.to change { Enrollment.count }.by(1)

          enrollment = Enrollment.last
          expect(enrollment.user_id).to eq(123)
          expect(enrollment.course_id).to eq(456)
        end
      end

      context 'when user does not exist' do
        let(:enrollments_data) { { user_id: -1, course_id: 456 }.with_indifferent_access }
        it 'enqueues a job' do
          allow(EnrollmentService).to receive(:list_enrollments).with(456, { page: 1 }).and_return({ "enrollments" => [ enrollments_data ] })
          allow(EnrollmentService).to receive(:list_enrollments).with(456, { page: 2 }).and_return({ "enrollments" => [] })

          expect { described_class.perform_now(456) }.to have_enqueued_job(UserSyncJob).once
        end
      end
    end
  end
end
