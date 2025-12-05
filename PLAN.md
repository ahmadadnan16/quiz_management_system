- **Assumptions**
  - Single Rails app (frontend + backend) with server-rendered HTML; no JS frameworks.
  - Authenticated “admin” experience can be simple (basic auth or Devise with admin flag).
  - Quiz is publicly accessible via a shareable slug/URL; no login needed to take a quiz.
  - Questions support MCQ (single choice), True/False, and short text answer; scoring only for objective types (MCQ, T/F).
  - Results shown immediately after submission; no persistence of respondent identity required.

- **Scope**
  - Admin can create/update quizzes: title, description, publish toggle.
  - Manage questions: type, prompt, options (for MCQ/T/F), correct answer (for auto-graded types), optional explanation.
  - Public quiz-taking page: render questions, accept responses, validate required answers, compute score for auto-gradable questions.
  - Results page: show score and correct answers for objective items; echo submitted text answers (not auto-graded).
  - Styling: minimal, clean Rails views (ERB), lightweight CSS (e.g., Bootstrap via CDN or simple custom CSS).
  - Database: PostgreSQL via ActiveRecord; migrations for quizzes, questions, options, submissions, answers.

- **Out of scope (for now)**
  - Rich RBAC, teams, analytics, versioning, timers, pagination for huge quizzes, accessibility polish beyond basics.
  - Partial saves, resumable attempts, randomized question order, multi-select MCQ.

- **Architecture / Data model**
  - `Quiz`: title, description, published:boolean, slug.
  - `Question`: quiz_id, prompt, kind (mcq|true_false|text), position, explanation, correct_answer (for T/F/text short), optional `points` (default 1).
  - `Option`: question_id, text, is_correct:boolean (for MCQ).
  - `Submission`: quiz_id, score, submitted_at.
  - `Answer`: submission_id, question_id, response_text, option_id, is_correct.
  - Service object to grade submissions; form object/controller flow handles creation + grading in one post.

- **Approach / Implementation steps**
  - Initialize Rails app (Postgres), add models/migrations above; seed demo quiz.
  - Admin auth (basic auth in controller for speed, or Devise if time).
  - Admin CRUD: simple Rails scaffold-ish controllers/views for quizzes/questions/options; nested forms for question creation.
  - Public flow: `QuizzesController#show` renders quiz; `SubmissionsController#create` processes answers, grades, saves submission + answers; redirect to `#result`.
  - Grading: only auto-grade MCQ (matching correct option) and T/F; text answers stored, marked null for correctness; sum points.
  - Views: ERB with plain form helpers; minimal CSS via CDN.
  - Tests: model specs for grading logic and validations; request spec for submission flow.

- **Scope changes during implementation**
  - Track any deviations (e.g., if switching auth method, or skipping nested form UX in favor of separate screens).

- **Reflection (end)**
  - What to improve next: richer auth/RBAC, better UX for quiz authoring, randomized ordering, multi-select, accessibility sweep, CI setup, more tests.
