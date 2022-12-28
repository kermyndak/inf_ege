require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  let(:email_tester) { 'tester@mail.ru' }
  let(:password_tester) { 'password' }

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
  end
end