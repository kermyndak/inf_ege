class Test < ApplicationRecord
    belongs_to :user

    def decode
      ActiveSupport::JSON.decode(self.answer)
    end

    def update_answer(number, id_task, result=0)
      arr = decode
      arr[number - 1] = [id_task, result]
      Test.update(answer: encode(arr))
    end

    def check(number) # false when task is not update
      task = decode[number - 1]
      (task[0].zero?) ? false : task[0]
    end

    private

    def encode(array)
      ActiveSupport::JSON.encode(array)
    end
end
