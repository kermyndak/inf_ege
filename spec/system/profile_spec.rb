require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  let(:email_tester) { 'tester@mail.ru' }
  let(:password_tester) { 'password' }
  let(:admin_mail) { 'admin@admin.ru' }

  Task.create(number: 1, path_image: '1-1.png', answer: '41')
  Task.create(number: 2, path_image: '2-1.png', answer: 'yxwz')
  Task.create(number: 3, path_image: '3-1.png', answer: '88479', file: '3-1.xls')

  scenario 'Examination' do
    visit '/log/sign_up'
    fill_in :email, with: email_tester
    fill_in :password, with: password_tester
    fill_in :password_confirmation, with: password_tester
    find('.btn-success').click
    sleep(0.5)
    expect(current_path).to eq('/log/sign_up')

    visit '/log/sign_in'
    sleep(0.5)
    fill_in :email, with: email_tester
    fill_in :password, with: password_tester
    find('.btn-success').click
    sleep(0.5)
    expect(current_path).to eq(root_path)

    click_link('tests-link-down')
    click_link('exam')
    sleep(0.5)
    expect(current_path).to eq('/task/exam')
  
    click_link('start-test')
    sleep(0.2)
    fill_in :answer, with: '41'
    find("a", class: 'small-number', text: "2").click
    sleep(0.5)
    fill_in :answer, with: 'yxwz'
    sleep(0.7)
    visit '/task/result?current_number=2&answer=yxwz'
    expect(find('#p-result')).to have_text('Ваш первичный балл: 2')
    visit root_path
    click_link('profile-link-down')
    sleep(0.2)
    click_link('tests-info')
    sleep(0.2)
    expect(current_path).to eq('/profile/tests_info')
    find('.btn-primary').click
    expect(find('#full')).to have_text("Результаты\nНомер Ваш ответ Правильный ответ Первичный балл\n1 41 41 1\n2 yxwz yxwz 1\n3 0\n4 0\n5 0\n6 0\n7 0\n8 0\n9 0\n10 0\n11 0\n12 0\n13 0\n14 0\n15 0\n16 0\n17 0\n18 0\n19 0\n20 0\n21 0\n22 0\n23 0\n24 0\n25 0\n26 0\n27 0\nᐱ")
    sleep(0.2)
    visit root_path
    click_link('profile-link-down')
    sleep(0.2)
    find('#open-profile').click
    sleep(0.2)
    expect(find('.container-md')).to have_text("Email:\ntester@mail.ru\nРоль:\nuser\nДата регистрации:\n10.1.2023\nКоличество пройденных тестов:\n1\nУровень: 1\n\n1\n2")
  end

  scenario 'Examination' do
    visit '/log/sign_up'
    fill_in :email, with: admin_mail
    fill_in :password, with: password_tester
    fill_in :password_confirmation, with: password_tester
    find('.btn-success').click
    sleep(0.5)
    expect(current_path).to eq('/log/sign_up')

    User.find(1).update_column(:role, 'admin')

    visit '/log/sign_in'
    sleep(0.5)
    fill_in :email, with: admin_mail
    fill_in :password, with: password_tester
    find('.btn-success').click
    sleep(0.5)
    expect(current_path).to eq(root_path)

    visit root_path
    click_link('profile-link-down')
    sleep(0.2)
    find('#open-profile').click
    sleep(0.2)
    expect(find('.container-md')).to have_text("Email:\nadmin@admin.ru\nРоль:\nadmin\nДата регистрации:\n10.1.2023\nКоличество пройденных тестов:\n0\nУровень: 1\n\n1\n2")
  end
end