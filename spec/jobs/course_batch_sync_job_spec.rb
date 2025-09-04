require 'rails_helper'

RSpec.describe CourseBatchSyncJob, type: :job do
  describe '#perform' do
    let(:course_data) { [ { "id" => 123, "name" => "Test Course" } ] }
    it 'syncs all courses' do
      allow(CourseService).to receive(:list_courses).with(page: 1).and_return({ "courses" => course_data })
      allow(CourseService).to receive(:list_courses).with(page: 2).and_return({ "courses" => [] })
      expect {
        described_class.perform_now
      }.to change { Course.count }.by(1)
    end
  end
end
