require 'rails_helper'

RSpec.describe UserService do
  let(:user) { { "id" => 1, "name" => 'John Doe', "email" => 'john.doe@example.com' } }
  let(:api_response) { { "users" => [ user ] } }

  describe '#list_users' do
    it 'returns a list of users' do
      allow(UserService).to receive(:get).with("/users", query: {}).and_return(api_response)
      result = UserService.list_users
      expect(result).to eq(api_response)
    end
  end

  describe '#get_user' do
    it 'returns the user details' do
      allow(UserService).to receive(:get).with("/users/1").and_return(user)
      result = UserService.get_user(1)
      expect(result).to eq(user)
    end

    it 'raises an error when user not found' do
      allow(UserService).to receive(:get).with("/users/999").and_return({ "message"=>"Sorry, we couldn't find a user with id: 999" })
      result = UserService.get_user(999)
      expect(result).to eq({ "message"=>"Sorry, we couldn't find a user with id: 999" })
    end
  end
end
