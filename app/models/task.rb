class Task < ApplicationRecord
  validates :number, {
    numericality: {
      greater_than: 0,
      less_than_or_equal_to: 27,
      message: 'Number task must be in range 1-27'
    }
  }
  validates :answer, {
    presence: {
      message: 'Answer can\t be empty'
    }
  }
end
