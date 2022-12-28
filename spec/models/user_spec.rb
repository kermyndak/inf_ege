require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'If adding with similar params' do
    before do
      User.create!(email: 'user@mail.ru', password: 'password', password_confirmation: 'password') if User.find_by(email: 'user@mail.ru').nil?
    end

    it 'should be error if input is not unique' do
      u = User.new(email: 'user@mail.ru', password: 'password', password_confirmation: 'password')
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["This email address is already registered"])
    end
  end

  describe 'If adding correct params' do
    before do
      User.destroy_by(email: 'user@mail.ru')
    end
    it 'Input correct values' do
      u = User.new(email: 'user@mail.ru', password: 'password', password_confirmation: 'password')
      expect(u.valid?).to be true
      expect(u.errors.objects.map(&:message)).to eq([])
    end
  end
end
