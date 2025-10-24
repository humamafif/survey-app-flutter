# 📝 IT Feedback

IT Feedback is a Flutter-based mobile application for creating and filling surveys. It includes authentication, management of lecturers and courses, question authoring and rendering, and response submission. The project follows a layered architecture (data → domain → presentation) and uses BLoC for state management.

## ✨ Key Features

- 🔐 Authentication — Google sign-in and session management
- 👩‍🏫 Lecturer (Dosen) management — fetch and list lecturer data
- 📚 Courses (Mata Kuliah) management — list and detail pages
- ❓ Survey Questions — question models, UI widgets, and survey flow
- 📨 Responses — submit and store user responses
- 🧩 Shared UI components — reusable widgets (cards, carousels, navigation)
- 🛠️ Utilities — validation helpers, shared preferences wrapper, snackbar helper

## 🗂️ Project Structure (important folders in `lib/`)

- `lib/core/` — application core: dependency injections, router, theming, and error models
- `lib/features/` — feature modules split by domain (auth, dosens, mata_kuliah, questions, responses). Each feature typically follows the data → domain → presentation pattern
- `lib/shared/` — shared pages and widgets used across the app (e.g., `home_page`, `profile_page`, `loading_page`)
- `lib/widget/` — reusable UI widgets such as `custom_card_survey`, carousels, and navigation bar
- `lib/firebase_options.dart` — Firebase configuration generated for the project

The `lib/features/<feature>/` layout commonly contains:

- `data/` — models, remote/local datasources, repository implementations
- `domain/` — entities, repository interfaces, usecases
- `presentation/` — BLoC, pages, and widgets

## ⚙️ Architecture & Patterns

- 🧱 Layered architecture: data → domain → presentation. This separates concerns and makes business logic easier to test.
- 🔁 BLoC is used for state management (see `presentation/bloc/*` folders for features like auth and questions)
- 🔌 Dependency injection is expected to be configured in `lib/core/injections.dart`
- ⚠️ Error and failure handling is centralized under `lib/core/error/`
