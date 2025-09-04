require 'rails_helper'

RSpec.describe CourseService do
  let(:course) { { "id" => 1, "name" => 'Math 101', "description" => 'Basic math course' } }
  let(:api_response) { { "courses" => [ course ] } }

  describe '#list_courses' do
    it 'returns a list of courses' do
      allow(CourseService).to receive(:get).with("/courses", query: {}).and_return(api_response)
      result = CourseService.list_courses
      expect(result).to eq(api_response)
    end
  end

  describe '#get_course' do
    it 'returns the course details' do
      allow(CourseService).to receive(:get).with("/courses/1").and_return(course)
      result = CourseService.get_course(1)
      expect(result).to eq(course)
    end

    it 'raises an error when course not found' do
      allow(CourseService).to receive(:get).with("/courses/999").and_return({ "message"=>"Sorry, we couldn't find a course with id: 999" })
      result = CourseService.get_course(999)
      expect(result).to eq({ "message"=>"Sorry, we couldn't find a course with id: 999" })
    end
  end
end
