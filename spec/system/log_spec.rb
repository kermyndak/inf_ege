require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  let(:email_tester) { 'tester@mail.ru' }
  let(:password_tester) { 'password' }

  scenario 'Sign up, Log in, Sign out' do
    visit '/log/sign_up'
    fill_in :email, with: email_tester
    fill_in :password, with: password_tester
    fill_in :password_confirmation, with: password_tester
    find('.btn-success').click
    sleep(1)
    expect(current_path).to eq('/log/sign_up')

    visit '/log/sign_in'
    sleep(1)
    fill_in :email, with: email_tester
    fill_in :password, with: password_tester
    find('.btn-success').click
    sleep(1)
    expect(current_path).to eq(root_path)

    visit root_path
    click_link('profile-link-down')
    click_button('sign-out-button')
    expect(current_path).to eq(root_path)
  end
end