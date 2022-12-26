class TaskController < ApplicationController
  before_action :set_params_test, only: %i[change_task task downloader result]
  before_action :set_params, only: %i[change_task task downloader]
  before_action :set_params_result, only: :result
  before_action :redirect_to_sign_up
  before_action :set_test_cookie, only: :task # set cookie time for test pages
  before_action :set_cookie, only: :result # set cookie time for result page
  def first_part
  end

  def second_part
  end

  def exam
  end

  def task
    @current.update_answer(@number, @id_task)
    @user_answer = @current.decode_user[@number - 1]
    if @type_test == 'first'
      render 'task_first'
    elsif @type_test == 'second'
      render 'task_second'
    end
  end

  def change_task
    unless @current.check(@number)
      @current.update_answer(@number, @id_task)
    end
    render turbo_stream: turbo_stream.update('task-block', partial: 'frame')
  end

  def downloader
    send_file(
      "#{Rails.root}/public/files/#{@file}",
      filename: "#{@number}#{@file[@file.index('.')..]}",
      type: "application/#{@file.index('.')}"
    )
  end

  def result
    @current.update(end: true)
    @balls = @current.decode.map { |id_task, ball| ball }.reduce(:+)
  end

  private

  def set_params
    @number = (params[:number].nil?) ? 1 : params[:number].to_i
    @number = 26 if @type_test == 'second'
    @current_number = params[:current_number].to_i
    @answer = params[:answer]
    @user_answer = @current.decode_user[@number - 1]
    @current.update_result(@current_number, @answer) if @answer # check answer on task
    return unless check_current_task
    generate_task
  end

  def generate_task
    where = Task.where(number: @number)
    @task = where[rand(where.size)]
    @formulation = @task.formulation
    @path_image = @task.path_image
    @file = @task.file
    @id_task = @task.id
  end

  def check_current_task
    if @current.check(@number)
      @id_task = @current.check(@number)
      @task = Task.find(@id_task)
      @formulation = @task.formulation
      @path_image = @task.path_image
      @file = @task.file
      return false
    end
    return true
  end

  def set_params_result
    @current_number = params[:current_number].to_i
    @answer = params[:answer]
    @current.update_result(@current_number, @answer) unless @answer.empty?
  end

  def set_params_test
    @type_test = params[:test]
    if Test.find_by(user_id: session[:current_user_id], end: 0).nil?
      @current = Test.create(user_id: session[:current_user_id], 
        type_test: @type_test)
    else
      @current = Test.find_by(user_id: session[:current_user_id], end: 0)
    end
  end

  def set_test_cookie
    if cookies[:login]
      if @type_test == 'exam'
        cookies[:login] = { value: session[:current_user_id], expires: (Time.now + 14100 + 600) } # 1 minute
      elsif @type_test == 'first'
        cookies[:login] = { value: session[:current_user_id], expires: (Time.now + 5400 + 600) } # 1 hour, 30 min + 1 minute
      elsif @type_test == 'second'
        cookies[:login] = { value: session[:current_user_id], expires: (Time.now + 8700 + 600) } # 2 hour, 25 min + 1 minute
      end
    else
      session[:current_user_id] = nil
    end
  end
end
