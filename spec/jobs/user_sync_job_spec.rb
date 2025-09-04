require 'rails_helper'

RSpec.describe UserSyncJob, type: :job do
  describe '#perform' do
    let(:user_data) { { "id" => 123, "name" => "Test User", "email" => "test@example.com" } }

    it 'syncs user data' do
      allow(UserService).to receive(:get_user).with(123).and_return(user_data)

      expect {
        described_class.perform_now(123)
      }.to change { User.count }.by(1)

      user = User.find_by(external_id: 123)
      expect(user.email).to eq('test@example.com')
      expect(user.name).to eq('Test User')
    end
  end
end
