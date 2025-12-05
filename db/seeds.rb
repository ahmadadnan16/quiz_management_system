# Clear existing data
Quiz.destroy_all

# Create a sample quiz
quiz = Quiz.create!(
  title: "General Knowledge Quiz",
  description: "Test your knowledge with this fun quiz covering various topics!",
  published: true
)

# Question 1: MCQ
q1 = quiz.questions.create!(
  prompt: "What is the capital of France?",
  question_type: "mcq",
  position: 1,
  points: 1,
  explanation: "Paris has been the capital of France since 987 AD."
)

q1.options.create!([
  { text: "London", is_correct: false, position: 1 },
  { text: "Paris", is_correct: true, position: 2 },
  { text: "Berlin", is_correct: false, position: 3 },
  { text: "Madrid", is_correct: false, position: 4 }
])

# Question 2: True/False
q2 = quiz.questions.create!(
  prompt: "The Earth is the third planet from the Sun.",
  question_type: "true_false",
  position: 2,
  points: 1,
  correct_answer: "true",
  explanation: "Yes, Earth is the third planet from the Sun, after Mercury and Venus."
)

# Question 3: MCQ
q3 = quiz.questions.create!(
  prompt: "Which programming language is known as the 'language of the web'?",
  question_type: "mcq",
  position: 3,
  points: 2,
  explanation: "JavaScript is the primary language used for web development."
)

q3.options.create!([
  { text: "Python", is_correct: false, position: 1 },
  { text: "JavaScript", is_correct: true, position: 2 },
  { text: "Java", is_correct: false, position: 3 },
  { text: "C++", is_correct: false, position: 4 }
])

# Question 4: True/False
q4 = quiz.questions.create!(
  prompt: "Ruby on Rails is a JavaScript framework.",
  question_type: "true_false",
  position: 4,
  points: 1,
  correct_answer: "false",
  explanation: "Ruby on Rails is actually a web application framework written in Ruby, not JavaScript."
)

# Question 5: Text
q5 = quiz.questions.create!(
  prompt: "What is the largest ocean on Earth?",
  question_type: "text",
  position: 5,
  points: 1,
  correct_answer: "Pacific Ocean",
  explanation: "The Pacific Ocean is the largest ocean, covering about one-third of the Earth's surface."
)

puts "Seed data created successfully!"
puts "Created quiz: #{quiz.title} (#{quiz.slug})"
puts "Created #{quiz.questions.count} questions"
