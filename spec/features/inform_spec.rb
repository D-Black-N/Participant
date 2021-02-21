require 'rails_helper'

RSpec.feature "Informs", type: :feature do
  context 'authentication' do
    scenario 'without authenticate' do
      visit root_url
      expect(page).to have_content('Авторизация')
    end
  
    scenario 'click authenticate link' do
      visit root_url
      click_link 'Авторизация'
      expect(page).to have_content('Авторизация')
    end
  end
  
  context 'student account' do
    let!(:user) {User.create(name: 'Bob', surname: 'Miles', email:'bob@gmail.com', password: 'qwerty', key_role: 'student')}
  
    before(:each) do
      visit new_user_session_path
      within('form') do 
        fill_in 'Почта', with: 'bob@gmail.com'
        fill_in 'Пароль', with: 'qwerty'
      end
      click_button 'Войти'
    end

    scenario 'click edit profile' do
      click_link 'Редактировать аккаунт'
      expect(page).to have_content 'Редактирование данных пользователя'
    end

    scenario 'edit profile' do
      visit edit_user_registration_path
      within('form') do
        fill_in 'Отчество', with: 'Ant'
        fill_in 'Текущий пароль', with: 'qwerty'
      end
      click_button 'Подтвердить'
      expect(page).to have_content 'Ваш аккаунт успешно обновлен'
    end

    scenario 'exit from account' do
      click_link 'Выход'
      expect(page).to have_content 'Успешный выход'
    end
  end

  context 'teacher account' do
    
    let!(:user) {User.create(name: 'Bob', surname: 'Miles', email:'bob@gmail.com', password: 'qwerty', key_role: 'teacher')}

    before(:each) do
      visit new_user_session_path
      within('form') do 
        fill_in 'Почта', with: 'bob@gmail.com'
        fill_in 'Пароль', with: 'qwerty'
      end
      click_button 'Войти'
    end

    scenario 'have link with new record' do
      expect(page).to have_content 'Достижения'
      expect(page).to have_content 'Тип аккаунта: teacher'
    end

    scenario 'click to add' do
      click_link 'Добавить'
      expect(page).to have_content 'Добавить достижение'
    end

    scenario 'add new record' do
      visit inform_add_path
      within('form') do
        fill_in 'Имя', with: 'Danil'
        fill_in 'Фамилия', with: 'Nasibullin'
        find('#classroom').find(:xpath, 'option[2]').select_option
        fill_in 'Мероприятие', with: 'ruby'
        find('#result').find(:xpath, 'option[2]').select_option
      end
      click_button 'Добавить'
      expect(page).to have_content 'Новые данные добавлены'
    end

    scenario 'don\'t add with duplicate record' do
      visit inform_add_path
      rec = Progress.create(name: 'danil', surname: 'nasibullin', classroom: '2', activity: 'ruby', result: 'Призер')
      within('form') do
        fill_in 'Имя', with: 'danil'
        fill_in 'Фамилия', with: 'nasibullin'
        find('#classroom').find(:xpath, 'option[2]').select_option
        fill_in 'Мероприятие', with: 'ruby'
        find('#result').find(:xpath, 'option[2]').select_option
      end
      click_button 'Добавить'
      expect(page).to have_content 'Данная запись уже существует'
    end

    scenario 'get all records' do
      visit root_url
      click_link 'Достижения'
      expect(page).to have_content 'Просмотр результатов'
    end

    scenario 'get to account' do
      visit inform_view_path
      click_link 'Аккаунт'
      expect(page).to have_content 'Ваш аккаунт'
    end
  end
end
