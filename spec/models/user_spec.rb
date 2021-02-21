require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new name:'Danil', 
                      surname:'Nasibullin',
                      email:'danil-nasibulin@mail.ru', 
                      key_role:'student', 
                      password:'FcnjyVfhnby'
  end

  describe 'new_user' do
    it 'should be valid with valid info' do 
      expect(@user).to be_valid
    end

    it 'should not be valid with not valid info' do
      @user.email=''
      expect(@user).to_not be_valid
    end

    it 'should find user from db' do
      @user.save
      find_user = User.find_by_email('danil-nasibulin@mail.ru')
      expect(find_user).to eq(@user)
    end

    it 'should not find user with invalid param' do
      @user.save
      find_user = User.find_by_email('danil@mail.ru')
      expect(find_user).to be(nil)
    end
  end
end
