class Admin::QuizzesController < Admin::BaseController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  
  def index
    @quizzes = Quiz.order(created_at: :desc)
  end
  
  def show
    @questions = @quiz.questions.ordered
  end
  
  def new
    @quiz = Quiz.new
  end
  
  def create
    @quiz = Quiz.new(quiz_params)
    
    if @quiz.save
      redirect_to admin_quiz_path(@quiz), notice: 'Quiz was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @quiz.update(quiz_params)
      redirect_to admin_quiz_path(@quiz), notice: 'Quiz was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @quiz.destroy
    redirect_to admin_quizzes_path, notice: 'Quiz was successfully deleted.'
  end
  
  private
  
  def set_quiz
    @quiz = Quiz.find_by!(slug: params[:id])
  end
  
  def quiz_params
    params.require(:quiz).permit(:title, :description, :published)
  end
end
