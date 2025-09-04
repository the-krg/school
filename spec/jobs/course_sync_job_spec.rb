require 'rails_helper'

RSpec.describe CourseSyncJob, type: :job do
  describe '#perform' do
    let(:course_data) { { id: 456, name: "Test Course", is_published: true }.with_indifferent_access }

    it 'syncs course data' do
      allow(CourseService).to receive(:get_course).with(456).and_return(course_data)

      expect {
        described_class.perform_now(456)
      }.to change { Course.count }.by(1)

      course = Course.last
      expect(course.external_id).to eq(456)
      expect(course.name).to eq("Test Course")
      expect(course.is_published).to eq(true)
    end
  end
end
