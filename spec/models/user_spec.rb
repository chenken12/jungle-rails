require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations User' do
    it 'should save new user in the db' do@user = User.new(first_name: "Ken", last_name: "Chen", email:"test@g.com", password: '123456', password_confirmation: '123456' )
      
      @user.save!
      expect(@user).to be_valid
    end

    it 'should throw an error if first_name is blank' do
      @user = User.new(first_name: nil, last_name: "Chen", email:"test@g.com", password: '123456', password_confirmation: '123456' )
      @user.save
      expect(@user.errors.full_messages ).to eq(["First name can't be blank"])
    end

    it 'should throw an error if last_name is blank' do
      @user = User.new(first_name: "Ken", last_name: nil, email:"test@g.com", password: '123456', password_confirmation: '123456' )
      @user.save
      expect(@user.errors.full_messages ).to eq(["Last name can't be blank"])
    end

    it 'should throw an error if email is blank' do
      @user = User.new(first_name: "Ken", last_name: "Chen", email: nil, password: '123456', password_confirmation: '123456' )
      @user.save
      expect(@user.errors.full_messages ).to eq(["Email can't be blank"])
    end
    it 'should throw an error if email is is the same' do
      @user1 = User.new(first_name: "Ken", last_name: "Chen", email: "TEST@g.com", password: '123456', password_confirmation: '123456' )
      @user1.save
      @user2 = User.new(first_name: "Ken", last_name: "Chen", email: "test@g.COM", password: '123456', password_confirmation: '123456' )
      @user2.save
      expect(@user2.errors.full_messages ).to eq(["Email has already been taken"])
    end

    it 'should throw an error if password is blank' do
      @user = User.new(first_name: "Ken", last_name: "Chen", email: "test@g.com", password: nil, password_confirmation: nil )
      @user.save
      expect(@user.errors.full_messages ).to include("Password can't be blank")
    end
    it 'should throw an error if password is not matching' do
      @user = User.new(first_name: "Ken", last_name: "Chen", email: "test@g.com", password: "123456", password_confirmation: "456789" )
      @user.save
      expect(@user.errors.full_messages ).to include("Password confirmation doesn't match Password")
    end
    it 'should throw an error if password is too short' do
      @user = User.new(first_name: "Ken", last_name: "Chen", email: "test@g.com", password: "1234", password_confirmation: "1234" )
      @user.save
      expect(@user.errors.full_messages ).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should be able sign in with valid credentials' do
      @user = User.create(first_name: "Ken", last_name: "Chen", email:"test@g.com", password: '123456', password_confirmation: '123456' )
      @signin = User.authenticate_with_credentials("test@g.com", "123456")

      expect(@user).to eq(@signin)
    end

    it 'should not be able sign in with invalid credentials' do
      @user = User.create(first_name: "Ken", last_name: "Chen", email:"test@g.com", password: '123456', password_confirmation: '123456' )
      @signin = User.authenticate_with_credentials("test@g.com", "456789")

      expect(@user).to_not eq(@signin)
      expect(@signin).to eq(nil)
    end

    it 'should not be able sign in with whitespace in between email' do
      @user = User.create(first_name: "Ken", last_name: "Chen", email:"test@g.com", password: '123456', password_confirmation: '123456' )
      @signin = User.authenticate_with_credentials("  test@g.com  ", "123456")

      expect(@user).to eq(@signin)
    end

    it 'should not be able sign in with Uppercass in email' do
      @user = User.create(first_name: "Ken", last_name: "Chen", email:"test@g.com", password: '123456', password_confirmation: '123456' )
      @signin = User.authenticate_with_credentials("TEST@G.COM", "123456")

      expect(@user).to eq(@signin)
    end
  end
end
