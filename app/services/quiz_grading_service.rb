class QuizGradingService
  def initialize(submission, answers_params)
    @submission = submission
    @quiz = submission.quiz
    @answers_params = answers_params
  end
  
  def grade!
    score = 0
    total_points = 0
    
    # Calculate total points first
    @quiz.questions.ordered.each do |question|
      total_points += question.points
    end
    
    # Save submission with initial values so we can create answers
    @submission.total_points = total_points
    @submission.score = 0
    @submission.save!
    
    @quiz.questions.ordered.each do |question|
      
      answer_data = @answers_params[question.id.to_s]
      next unless answer_data
      
      answer = @submission.answers.build(question: question)
      
      if question.mcq?
        option_id = answer_data[:option_id].to_i
        option = question.options.find_by(id: option_id)
        
        if option&.is_correct?
          score += question.points
          answer.is_correct = true
        else
          answer.is_correct = false
        end
        
        answer.option_id = option_id
      elsif question.true_false?
        response = answer_data[:response_text]
        correct_answer = question.correct_answer
        
        if response == correct_answer
          score += question.points
          answer.is_correct = true
        else
          answer.is_correct = false
        end
        
        answer.response_text = response
      elsif question.text?
        # Text questions are not auto-graded
        answer.response_text = answer_data[:response_text]
        answer.is_correct = nil
      end
      
      answer.save!
    end
    
    @submission.update!(
      score: score,
      total_points: total_points,
      submitted_at: Time.current
    )
    
    @submission
  end
end

