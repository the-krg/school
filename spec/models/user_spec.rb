require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(external_id: 1, email: "test@example.com", name: "test user") }
  describe 'associations' do
    it { should have_many(:enrollments).dependent(:destroy) }
    it { should have_many(:courses).through(:enrollments) }
  end
  describe 'validations' do
    it { should validate_presence_of(:external_id) }
    it { should validate_uniqueness_of(:external_id) }
  end
end
