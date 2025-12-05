class Option < ApplicationRecord
  belongs_to :question
  has_many :answers, dependent: :destroy
  
  validates :text, presence: true
  
  scope :ordered, -> { order(:position, :id) }
end
