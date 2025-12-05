class Answer < ApplicationRecord
  belongs_to :submission
  belongs_to :question
  belongs_to :option, optional: true
  
  validates :question_id, presence: true
  validate :has_response
  
  private
  
  def has_response
    if option_id.blank? && response_text.blank?
      errors.add(:base, "Must provide either an option or text response")
    end
  end
end
