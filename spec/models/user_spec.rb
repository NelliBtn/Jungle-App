require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'User validations' do

    before :each do
      @user = User.new(name: "UserName",
                      email: "user@gmail.com",
                      password: "password",
                      password_confirmation: "password",
                      created_at: DateTime.now,
                      updated_at: DateTime.now)
    end

    it "should be valid when all atributes are provided and valid" do
      expect(@user).to be_valid 
    end

    it "should fail without name" do
      @user.name = nil
      expect(@user).to_not be_valid 
    end

    it "should fail without email" do
      @user.email = nil
      expect(@user).to_not be_valid 
    end

    it "should fail if email is not unique (not case sensitive)" do
      @user.save
      user1 = User.new(name: "UserName1",
                      email: "USER@gmail.com",
                      password: "password1",
                      password_confirmation: "password1",
                      created_at: DateTime.now,
                      updated_at:DateTime.now)
      user1.save
      expect(user1).to_not be_valid
      expect(user1.errors.full_messages).to include("Email has already been taken")
    end

    it "should fail without password" do
      @user.password = nil
      expect(@user).to_not be_valid 
    end

    it "should fail with password less than 8 chars" do
      @user.password = "user"
      expect(@user).to_not be_valid 
    end

    it 'should fail when password and its confirmation do not match' do
      @user.password_confirmation = "fail"
      expect(@user).to_not be_valid 
    end
  end

  describe '.authenticate_with_credentials' do
    before :each do
      @user = User.new(name: "UserName",
                      email: "user@gmail.com",
                      password: "password",
                      password_confirmation: "password",
                      created_at: DateTime.now,
                      updated_at:DateTime.now)
    end
    
    it "should login with valid email and password" do
      @user.save
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end

    it "should fail with unvalid email or password" do
      @user.save
      expect(User.authenticate_with_credentials(nil, @user.password)).to be_nil
    end

    it "should login with valid email with whitespaces" do
      @user.save
      expect(User.authenticate_with_credentials("   user@gmail.com ", @user.password)).to eq(@user)
    end

  end
  

end
