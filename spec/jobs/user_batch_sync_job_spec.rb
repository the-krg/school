require 'rails_helper'

RSpec.describe UserBatchSyncJob, type: :job do
  describe '#perform' do
    let(:user_data) { [ { "id" => 123, "name" => "Test User", "email" => "test@example.com" } ] }

    context 'when user_ids are provided' do
      it 'enqueues an UserSyncJob for each id provided' do
        expect {
          described_class.perform_now([ 123, 456 ])
        }.to have_enqueued_job(UserSyncJob).exactly(2).times
      end
    end

    context 'when no user_ids are provided' do
      it 'syncs all users' do
        allow(UserService).to receive(:list_users).with(page: 1).and_return({ "users" => user_data })
        allow(UserService).to receive(:list_users).with(page: 2).and_return({ "users" => [] })
        expect {
          described_class.perform_now([])
        }.not_to have_enqueued_job(UserSyncJob)

        user = User.find_by(external_id: 123)
        expect(user.email).to eq('test@example.com')
        expect(user.name).to eq('Test User')
      end
    end
  end
end
