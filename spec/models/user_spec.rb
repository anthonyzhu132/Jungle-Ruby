require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "Valid with all fields" do
      user = User.new(name: 'Dank', email: 'meme@me.com', password: 'dankmeme123', password_confirmation: 'dankmeme123')
      user.save
      expect(user).to be_valid
    end

    it "Not valid when password and password_confirmation do not match" do
      user = User.new(name: 'Dank', email: 'meme@me.com', password: 'dankmeme123', password_confirmation: 'dankmeme12223')
      user.save
      expect(user).to_not be_valid
    end

    it "Not valid when email #1 and email #2 do not match" do
      user = User.new(name: 'Dank', email: 'meme@me.com', password: 'dankmeme123', password_confirmation: 'dankmeme12223')
      user2 = User.new(name: 'Dank2', email: 'meme@me.com', password: 'dankmeme123', password_confirmation: 'dankmeme12223')
      user.save
      user2.save
      expect(user2).to_not be_valid
    end

    it "Not valid when a password is not present" do
      user = User.new(name: 'Dank', email: 'meme@me.com', password: nil, password_confirmation: 'dankmeme12223')
      user.save
      expect(user).to_not be_valid
    end
    
    it "Not valid when a password length is too short" do
      user = User.new(name: 'Dank', email: 'meme@me.com', password: '123', password_confirmation: '123')
      user.save
      expect(user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'Login with the correct login details' do
      user = User.new(name: 'dank', email: 'dank@dank.me', password: '123456', password_confirmation: '123456')
      user.save!
      expect(user.authenticate_with_credentials('dank@dank.me', '123456')).to eql(user)
    end

    it 'Not login with the incorrect login details' do
      user = User.new(name: 'dank', email: 'dank@dank.me', password: '123456', password_confirmation: '123456')
      user.save!
      expect(user.authenticate_with_credentials('dank@dank.me', '12345226')).to_not eql(user)
    end
  end
end
