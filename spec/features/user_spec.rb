require 'rails_helper'

RSpec.feature "Users", type: :feature do

  context 'registration' do
    scenario 'success registration' do
      visit new_user_registration_path
      within('form') do
        fill_in 'Имя', with: 'Danil'
        fill_in 'Фамилия', with: 'Nasibullin'
        fill_in 'Почта', with: 'danil@mail.ru'
        fill_in 'Пароль', with: '123456'
        fill_in 'Подтвердить пароль', with: '123456'
        choose('user_key_role_student')
      end
      click_button 'Зарегистрироваться'
      expect(page).to have_content('Пользователь успешно создан')
    end
  
    scenario 'failed registration' do
      visit new_user_registration_path
      within('form') do
        fill_in 'Имя', with: 'Danil'
        fill_in 'Фамилия', with: 'Nasibullin'
        fill_in 'Почта', with: 'danil@mail.ru'
        fill_in 'Пароль', with: '123456'
        fill_in 'Подтвердить пароль', with: '123456'
      end
      click_button 'Зарегистрироваться'
      expect(page).to have_content('Пользователь не создан. Ошибка ввода')
    end
  
    scenario 'failed registration with duplicated email' do
      visit new_user_registration_path
      within('form') do
        fill_in 'Имя', with: 'Danil'
        fill_in 'Фамилия', with: 'Nasibullin'
        fill_in 'Почта', with: 'bob@gmail.com'
        fill_in 'Пароль', with: '123456'
        fill_in 'Подтвердить пароль', with: '123456'
      end
      click_button 'Зарегистрироваться'
      expect(page).to have_content('Пользователь не создан. Ошибка ввода')
    end
  
    scenario 'click log in in registration form' do
      visit new_user_registration_path
      click_link 'Авторизоваться'
      expect(page).to have_content 'Зарегистрироваться'
    end
  end

  context 'authentication' do
  
    let!(:teacher) { User.create(name: 'Bobi', surname: 'Miles', email:'bobi@gmail.com', password: 'qwerty', key_role: 'teacher')}
    let!(:student) { User.create(name: 'Bob', surname: 'Ant', email:'bob@gmail.com', password: 'qwerty', key_role: 'student')}

    scenario 'student account authentication' do
      visit new_user_session_path
      within('form') do 
        fill_in 'Почта', with: 'bob@gmail.com'
        fill_in 'Пароль', with: 'qwerty'
      end
      click_button 'Войти'
      expect(page).to have_content 'Тип аккаунта: student'
      expect(page).to have_content 'Успешный вход'
    end
  
    scenario 'teacher account authentication' do
      visit new_user_session_path
      within('form') do
        fill_in 'Почта', with: 'bobi@gmail.com'
        fill_in 'Пароль', with: 'qwerty'
      end
      click_button 'Войти'
      expect(page).to have_content 'Тип аккаунта: teacher'
      expect(page).to have_content 'Успешный вход'
    end
  end

  context 'admin' do

    before(:each) do
      visit new_user_session_path
      within('form') do
        fill_in 'Почта', with: 'admin@gmail.com'
        fill_in 'Пароль', with: 'qwerty'
      end
      click_button 'Войти'
    end

    let!(:admin) { User.create(name: 'Bobi', surname: 'Miles', email:'bobi@gmail.com', password: 'qwerty', key_role: 'admin')}
    let!(:student) { User.create(name: 'Bob', surname: 'Ant', email:'bob@gmail.com', password: 'qwerty', key_role: 'student')}

    scenario 'delete user' do
      visit users_all_path
      expect(page).to have_content 'Bob'
      click_link 'Удалить'
      expect(page).to have_no_content 'Bob'
    end
  end
end
