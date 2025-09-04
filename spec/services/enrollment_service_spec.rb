require 'rails_helper'

RSpec.describe EnrollmentService do
  let(:enrollment) { { "user_id" => 1, "course_id" => 123 } }
  let(:api_response) { { "enrollments" => [ enrollment ] } }

  describe '#list_enrollments' do
    it 'returns a list of enrollments' do
      allow(EnrollmentService).to receive(:get).with("/courses/123/enrollments", query: {}).and_return(api_response)
      result = EnrollmentService.list_enrollments(123)
      expect(result).to eq(api_response)
    end
  end
end
