class SubmissionsController < ApplicationController
  def create
    @quiz = Quiz.published.find_by!(slug: params[:slug])
    
    @submission = @quiz.submissions.build
    answers_params = params[:answers] || {}
    
    QuizGradingService.new(@submission, answers_params).grade!
    
    redirect_to quiz_results_path(@quiz, @submission), notice: 'Quiz submitted successfully!'
  rescue ActiveRecord::RecordInvalid => e
    @questions = @quiz.questions.ordered.includes(:options)
    Rails.logger.error "Submission error: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    flash.now[:alert] = "There was an error submitting your quiz: #{e.message}"
    render 'quizzes/show', status: :unprocessable_entity
  rescue StandardError => e
    @questions = @quiz.questions.ordered.includes(:options)
    Rails.logger.error "Submission error: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    flash.now[:alert] = "There was an error submitting your quiz. Please try again."
    render 'quizzes/show', status: :unprocessable_entity
  end
  
  def show
    @quiz = Quiz.published.find_by!(slug: params[:slug])
    @submission = @quiz.submissions.find(params[:submission_id])
    @questions = @quiz.questions.ordered.includes(:options)
    @answers_by_question = @submission.answers.index_by(&:question_id)
  end
end
