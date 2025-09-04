require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { described_class.new(external_id: 1, name: "Test Course", is_published: true) }

  describe 'validations' do
    it { should validate_presence_of(:external_id) }
    it { should validate_uniqueness_of(:external_id) }
  end

  describe 'associations' do
    it { should have_many(:enrollments).dependent(:destroy) }
    it { should have_many(:students).through(:enrollments) }
  end
end
