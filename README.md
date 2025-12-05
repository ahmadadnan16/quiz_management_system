# Quiz Management System

A production-ready quiz management system built with Ruby on Rails, featuring an admin panel for creating quizzes and a public interface for taking quizzes.

## Features

### Admin Panel
- Create, edit, and delete quizzes
- Add questions with multiple types:
  - **Multiple Choice (MCQ)**: Add multiple options with one correct answer
  - **True/False**: Boolean questions
  - **Text**: Short text answers (not auto-graded)
- Manage question options for MCQ questions
- Publish/unpublish quizzes
- Automatic slug generation for quizzes
- HTTP Basic Authentication for admin access

### Public Interface
- Browse published quizzes
- Take quizzes with all question types
- Automatic grading for MCQ and True/False questions
- View results with:
  - Score and percentage
  - Correct/incorrect answers
  - Explanations (if provided)
  - Correct answers for reference

## Tech Stack

- **Backend**: Ruby on Rails 7.1.6
- **Frontend**: Server-rendered HTML with ERB templates
- **Database**: PostgreSQL
- **Styling**: Bootstrap 5 (via CDN)
- **Ruby Version**: 3.0.0

## Prerequisites

- Ruby 3.0.0 (managed via RVM)
- PostgreSQL (version 9.3 or higher)
- Bundler gem
- Git

## Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd quiz_app
   ```

2. **Install Ruby dependencies**
   ```bash
   rvm use 3.0.0
   bundle install
   ```

3. **Configure database**
   
   Update `config/database.yml` with your PostgreSQL credentials:
   ```yaml
   development:
     database: quiz_app_development
     username: your_username
     password: your_password
     host: localhost
     port: 5432
   ```

4. **Create and setup database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. **Set admin credentials (optional)**
   
   By default, admin credentials are:
   - Username: `admin`
   - Password: `password`
   
   To customize, set environment variables:
   ```bash
   export ADMIN_USERNAME=your_admin_username
   export ADMIN_PASSWORD=your_admin_password
   ```

## Running the Application

1. **Start the Rails server**
   ```bash
   rails server
   ```
   Or run in the background:
   ```bash
   rails server -d
   ```

2. **Access the application**
   - Public interface: http://localhost:3000
   - Admin panel: http://localhost:3000/admin/quizzes

## Usage

### Admin Panel

1. **Access Admin Panel**
   - Navigate to `/admin/quizzes`
   - Enter admin credentials when prompted

2. **Create a Quiz**
   - Click "New Quiz"
   - Enter title and description
   - Check "Published" to make it publicly available
   - Click "Create Quiz"

3. **Add Questions**
   - Click on a quiz to view/edit
   - Click "Add Question"
   - Select question type:
     - **MCQ**: Enter prompt, then save and click "Manage Options" to add answer choices
     - **True/False**: Enter prompt and select correct answer
     - **Text**: Enter prompt and optional reference answer
   - Set points and position
   - Add optional explanation

4. **Manage MCQ Options**
   - For MCQ questions, click "Manage Options"
   - Add multiple options
   - Mark exactly one option as correct
   - Set option positions for ordering

### Public Interface

1. **Take a Quiz**
   - Visit the homepage to see published quizzes
   - Click "Take Quiz" on any quiz
   - Answer all questions
   - Click "Submit Quiz"

2. **View Results**
   - After submission, view your score
   - See correct/incorrect answers
   - Read explanations (if provided)

## Database Schema

### Models

- **Quiz**: Title, description, slug, published status
- **Question**: Prompt, type (mcq/true_false/text), points, correct_answer, explanation
- **Option**: Text, is_correct (for MCQ questions)
- **Submission**: Score, total_points, submitted_at
- **Answer**: Stores user responses with grading results

## Project Structure

```
quiz_app/
├── app/
│   ├── controllers/
│   │   ├── admin/
│   │   │   ├── base_controller.rb      # Admin authentication
│   │   │   ├── quizzes_controller.rb
│   │   │   ├── questions_controller.rb
│   │   │   └── options_controller.rb
│   │   ├── quizzes_controller.rb       # Public quiz display
│   │   └── submissions_controller.rb   # Quiz submission & results
│   ├── models/
│   │   ├── quiz.rb
│   │   ├── question.rb
│   │   ├── option.rb
│   │   ├── submission.rb
│   │   └── answer.rb
│   ├── services/
│   │   └── quiz_grading_service.rb     # Grading logic
│   └── views/
│       ├── admin/                       # Admin panel views
│       └── quizzes/                     # Public quiz views
├── config/
│   ├── routes.rb                        # Application routes
│   └── database.yml                     # Database configuration
├── db/
│   ├── migrate/                         # Database migrations
│   └── seeds.rb                         # Seed data
└── PLAN.md                              # Implementation plan
```

## Routes

### Admin Routes (Protected)
- `GET /admin/quizzes` - List all quizzes
- `GET /admin/quizzes/new` - New quiz form
- `POST /admin/quizzes` - Create quiz
- `GET /admin/quizzes/:id` - Show quiz
- `GET /admin/quizzes/:id/edit` - Edit quiz form
- `PATCH /admin/quizzes/:id` - Update quiz
- `DELETE /admin/quizzes/:id` - Delete quiz
- `GET /admin/quizzes/:quiz_id/questions` - List questions
- `GET /admin/quizzes/:quiz_id/questions/new` - New question form
- `POST /admin/quizzes/:quiz_id/questions` - Create question
- `GET /admin/quizzes/:quiz_id/questions/:id/edit` - Edit question
- `PATCH /admin/quizzes/:quiz_id/questions/:id` - Update question
- `DELETE /admin/quizzes/:quiz_id/questions/:id` - Delete question
- `GET /admin/quizzes/:quiz_id/questions/:question_id/options` - List options
- `POST /admin/quizzes/:quiz_id/questions/:question_id/options` - Create option
- `PATCH /admin/quizzes/:quiz_id/questions/:question_id/options/:id` - Update option
- `DELETE /admin/quizzes/:quiz_id/questions/:question_id/options/:id` - Delete option

### Public Routes
- `GET /` - Homepage (list published quizzes)
- `GET /quizzes/:slug` - Take quiz
- `POST /quizzes/:slug/submit` - Submit quiz
- `GET /quizzes/:slug/results/:submission_id` - View results

## Seed Data

The application includes seed data with a sample quiz:
- Quiz: "General Knowledge Quiz"
- 5 questions covering all question types
- Ready to test immediately after setup

To reset seed data:
```bash
rails db:seed:replant
```

## Development

### Running Tests
```bash
rails test
```

### Console
```bash
rails console
```

### Database Console
```bash
rails dbconsole
```

### View Logs
```bash
tail -f log/development.log
```

## Configuration

### Environment Variables

- `ADMIN_USERNAME`: Admin username (default: `admin`)
- `ADMIN_PASSWORD`: Admin password (default: `password`)
- `DATABASE_URL`: PostgreSQL connection URL (optional)

### Database Configuration

Edit `config/database.yml` to configure database connections for different environments.

## Troubleshooting

### Database Connection Issues
- Ensure PostgreSQL is running
- Verify credentials in `config/database.yml`
- Check database exists: `rails db:create`

### Admin Authentication Issues
- Verify environment variables are set correctly
- Check browser is not caching old credentials
- Try clearing browser cache

### Quiz Submission Errors
- Check that all required fields are filled
- Verify quiz is published
- Check Rails logs: `tail -f log/development.log`

## Future Enhancements

See `PLAN.md` for detailed reflection on potential improvements including:
- Enhanced authentication system
- Analytics and reporting
- Time limits
- Multiple attempts
- API development
- And more...

## License

This project is part of a coding assessment.

## Author

Built as a production-ready quiz management system demonstration.
