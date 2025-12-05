class Admin::OptionsController < Admin::BaseController
  before_action :set_quiz
  before_action :set_question
  before_action :set_option, only: [:show, :edit, :update, :destroy]
  
  def index
    @options = @question.options.ordered
  end
  
  def show
  end
  
  def new
    @option = @question.options.build
  end
  
  def create
    @option = @question.options.build(option_params)
    
    if @option.save
      redirect_to admin_quiz_question_options_path(@quiz, @question), notice: 'Option was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @option.update(option_params)
      redirect_to admin_quiz_question_options_path(@quiz, @question), notice: 'Option was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @option.destroy
    redirect_to admin_quiz_question_options_path(@quiz, @question), notice: 'Option was successfully deleted.'
  end
  
  private
  
  def set_quiz
    @quiz = Quiz.find_by!(slug: params[:quiz_id])
  end
  
  def set_question
    @question = @quiz.questions.find(params[:question_id])
  end
  
  def set_option
    @option = @question.options.find(params[:id])
  end
  
  def option_params
    params.require(:option).permit(:text, :is_correct, :position)
  end
end
