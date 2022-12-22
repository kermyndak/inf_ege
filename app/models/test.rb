class Test < ApplicationRecord
    belongs_to :user

    def decode
      ActiveSupport::JSON.decode(self.answer)
    end

    def decode_user
      ActiveSupport::JSON.decode(self.user_answer)
    end

    def update_answer(number, id_task, result=0)
      arr = decode
      arr[number - 1] = [id_task, result]
      update(answer: encode(arr))
    end

    def check(number) # false when task is not update
      task = decode[number - 1]
      (task[0].zero?) ? false : task[0]
    end

    def update_result(number, value)
      arr = decode
      task = Task.find(arr[number - 1][0])
      answers = decode_user
      answers[number - 1] = value
      arr[number - 1][1] = (task.answer == value) ? 1 : 0
      update(answer: encode(arr))
      update(user_answer: encode(answers))
    end

    private

    def encode(array)
      ActiveSupport::JSON.encode(array)
    end
end
