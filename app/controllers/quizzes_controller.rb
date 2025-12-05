class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.published.order(created_at: :desc)
  end
  
  def show
    @quiz = Quiz.published.find_by!(slug: params[:slug])
    @questions = @quiz.questions.ordered.includes(:options)
  end
end
