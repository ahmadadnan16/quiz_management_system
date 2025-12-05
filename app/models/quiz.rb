class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :submissions, dependent: :destroy
  
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  
  before_validation :generate_slug, on: :create
  
  scope :published, -> { where(published: true) }
  
  def to_param
    slug
  end
  
  private
  
  def generate_slug
    return if slug.present?
    
    base_slug = title.parameterize
    candidate_slug = base_slug
    counter = 1
    
    while Quiz.exists?(slug: candidate_slug)
      candidate_slug = "#{base_slug}-#{counter}"
      counter += 1
    end
    
    self.slug = candidate_slug
  end
end
