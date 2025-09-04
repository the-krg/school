require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  let(:user) { User.new(external_id: 1, email: "test@example.com", name: "Test User") }
  let(:course) { Course.new(external_id: 1, name: "Test Course", is_published: true) }

  subject { described_class.new(user: user, course: course) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:course) }
  end
end
