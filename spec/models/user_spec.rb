require 'rails_helper'

RSpec.describe User, type: :model do
  context 'valid attributes' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  context 'authentication' do
    it 'is invalid without a password' do
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end

    it 'is invalid without a password confirmation' do
      user = build(:user, password_confirmation: nil)
      expect(user).to_not be_valid
    end
    
    it 'hashes the password' do
      user = create(:user)
      expect(user.password_digest).to_not eq('password')
    end
  end
end
