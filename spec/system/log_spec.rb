require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  let(:email_tester) { 'tester@mail.ru' }
  let(:password_tester) { 'password' }
  let(:password_confirmation_tester) { 'password' }

  scenario 'Sign up, Log in' do
    visit '/log/sign_up'
    fill_in :email, with: email_tester
    fill_in :password, with: password_tester
    fill_in :password_confirmation, with: password_confirmation_tester
    find('.btn').click
    expect(current_page).to eq(root_path)
  end

end