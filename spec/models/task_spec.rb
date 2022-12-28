require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'If adding with similar params' do
    it 'should be bad message' do
      u = Task.new(number: 25)
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Answer can\\t be empty"])
    end

    it 'Correct params for add task' do
      u = Task.new(number: 25, answer: '123')
      expect(u.valid?).to be true
      expect(u.errors.objects.map(&:message)).to eq([])
    end
  end
end
