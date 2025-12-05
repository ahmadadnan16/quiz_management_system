class Submission < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy
  
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_points, presence: true, numericality: { greater_than: 0 }
  
  def percentage
    return 0 if total_points.zero?
    ((score.to_f / total_points) * 100).round(2)
  end
end
