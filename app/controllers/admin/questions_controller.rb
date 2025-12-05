class Admin::QuestionsController < Admin::BaseController
  before_action :set_quiz
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  
  def index
    @questions = @quiz.questions.ordered
  end
  
  def show
  end
  
  def new
    @question = @quiz.questions.build
  end
  
  def create
    @question = @quiz.questions.build(question_params)
    
    if @question.save
      redirect_to admin_quiz_questions_path(@quiz), notice: 'Question was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @question.update(question_params)
      redirect_to admin_quiz_questions_path(@quiz), notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @question.destroy
    redirect_to admin_quiz_questions_path(@quiz), notice: 'Question was successfully deleted.'
  end
  
  private
  
  def set_quiz
    @quiz = Quiz.find_by!(slug: params[:quiz_id])
  end
  
  def set_question
    @question = @quiz.questions.find(params[:id])
  end
  
  def question_params
    params.require(:question).permit(:prompt, :question_type, :position, :points, :correct_answer, :explanation)
  end
end
