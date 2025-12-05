class Question < ApplicationRecord
  belongs_to :quiz
  has_many :options, dependent: :destroy
  has_many :answers, dependent: :destroy
  
  validates :prompt, presence: true
  validates :question_type, presence: true, inclusion: { in: %w[mcq true_false text] }
  validates :points, presence: true, numericality: { greater_than: 0 }
  
  scope :ordered, -> { order(:position, :id) }
  
  QUESTION_TYPES = %w[mcq true_false text].freeze
  
  def mcq?
    question_type == 'mcq'
  end
  
  def true_false?
    question_type == 'true_false'
  end
  
  def text?
    question_type == 'text'
  end
  
  def auto_gradable?
    mcq? || true_false?
  end
end
