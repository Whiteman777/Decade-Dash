# Decade Dash

A clean, well-architected Flutter quiz app covering seven decades of music, movies, and pop culture (1950s–2020s). Pick your difficulty and round timer, tap through ten questions with instant feedback, use hints when you're stuck, and finish on a results screen that reviews every answer.

## Download

### 📱 Try the App

**[Download Decade Dash v1.0.0 (APK)](https://drive.google.com/file/d/1G3LbRvPD6oB1exTJX5zzl8mmG0ZtFOmj2/view?usp=sharing)**

**Requirements:**
- Android 5.0 (Lollipop) or higher
- ~15 MB download (choose the APK matching your device's CPU below)

**Installation:**
1. Download the APK from the link above
2. On your Android device, go to **Settings → Security**
3. Enable **"Install from unknown sources"** (or "Allow installs from this source" on newer Android)
4. Open the downloaded APK file and tap **Install**
5. Launch the app and start the quiz!

## Overview

Decade Dash is a Flutter quiz application built around a decade-themed question bank spanning the 1950s through the 2020s. Before each round you configure the **difficulty** (easy / medium / hard) and the **time allowed per question** (10 / 15 / 20 seconds). You then answer ten questions by tapping answer cards, with the ability to **reveal the correct answer** or **use a hint** when you're unsure. The round ends on a results screen that shows your score and a full per-question review, including whether you used a hint on each question.

The app demonstrates Flutter fundamentals: lifted state management, stateful/stateless widget composition, callback-based parent→child communication, custom theming, and reusable button components.

## Screenshots

*Coming soon*

## Features

- **10 questions per round** while staying on track with a per-question timer
- **Configurable difficulty**  easy / medium / hard changes question selection
- **Tracked hint usage**  using a hint records it per question and surfaces it in the review
- **Reveal answer**  toggle to check the right answer mid-question
- **Answer cards** with selected / correct / incorrect states and instant feedback
- **Results screen** showing your score plus a review of each question and answer
- **Clean Material Design UI** with gradient backgrounds and a branded app bar
- **Restart flow**  finish a round project's `.loose`, then start again without rebuilding

## Architecture

### State Management Pattern

The app uses the **lifted state pattern** where a single parent component (`Quiz`) owns all application state and passes it down to children:

```
Quiz (Stateful) — State Owner
│
├── screens            (enum: start / setup / question / result)
├── questionData       (the active set of questions)
├── correct            (running score)
├── results            (per-question QuizResult list)
│
├── StartScreen        (Stateless)
│   └── StartQuizButton
├── SetupScreen        (Stateless)
│   ├── DifficultyButton   (easy / medium / hard)
│   ├── DurationButton     (10 / 15 / 20 seconds)
│   └── StartButton
├── QuestionScreen     (Stateful — owns tap/reveal/hint UI state)
│   ├── AnswerCard
│   └── AnswerButton
└── ResultScreen       (Stateless)
    └── AnswerCard (result state)
```

**Key State Variables:**
- `screens` — an enum driving 4 screen states (`start`, `setup`, `question`, `result`)
- `questionIndex` — which question the player is on
- `correct` — the running count of correct answers
- `results` — `QuizResult` per question (question, selected answer, hint-used flag)

**Communication Flow:**
- Parent (`Quiz`) owns score + question selection + results
- `QuestionScreen` handles its own visual feedback (selected/correct/incorrect card states)
- Callbacks (`onSelectedAnswer`, `onNextQuestion`) flow back up to update parent state
- Parent re-renders on `setState`, cascading updates to children

### Why Lifted State?

- **Single source of truth**  score and results live in one place
- **Predictable data flow**  always parent → child, with callbacks up
- **Easy debugging**  state changes happen in one component
- **Component reusability**  screens stay stateless where possible

### Hint Tracking

Hints are tracked end to end. When a player uses a hint, it's recorded on the question's `QuizResult`, then rendered on the results screen:

```dart
class QuizResult {
  final Question question;
  final String? selectedAnswer;   // null = unanswered
  final bool didUseHint;          // true when a hint was used
}
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- Android Studio / VS Code with Flutter extensions

### Clone & Run

```bash
# Clone the repository
git clone https://github.com/Whiteman777/Decade-Dash.git
cd Decade-Dash

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Build APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

For smaller per-architecture APKs:

```bash
flutter build apk --release --split-per-abi
```

Output: `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` etc.

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8   # iOS-style icons

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0               # Code quality rules
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── data/
│   └── questions.dart        # Decade-themed question bank
├── enums/
│   ├── difficulty.dart       # easy / medium / hard
│   └── duration.dart         # 10 / 15 / 20 seconds
├── models/
│   ├── question.dart         # Question model (text, answers, hint, difficulty)
│   └── quiz_result.dart      # Per-question result (answer + hint-used flag)
├── theme/
│   └── background_theme.dart # Gradient background definition
└── widgets/
    ├── quiz.dart             # Main state container (Quiz, Stateful)
    ├── brand_app_bar.dart    # Reusable branded app bar
    ├── answer_card.dart      # Reusable answer card (question + result states)
    ├── buttons/
    │   ├── answer_button.dart      # Tap card for each option
    │   ├── start_button.dart       # "Start" on start/setup screens
    │   └── start_quiz_button.dart  # "Start Quiz" on the setup screen
    └── screens/
        ├── start_screen.dart       # Welcome (Stateless)
        ├── setup_screen.dart       # Difficulty + duration (Stateless)
        ├── question_screen.dart    # Quiz interface (Stateful)
        └── result_screen.dart      # Results display (Stateless)
```

## Extending the App

### Adding New Questions

Edit `lib/data/questions.dart` using the question model:

```dart
Question(
  'Which movie won Best Picture in 1984?',
  [
    'Amadeus',
    'The Killing Fields',
    'A Passage to India',
    'Places in the Heart',
  ],
  hint: 'It was a Wolfgang Amadeus Mozart biopic.',
  difficulty: Difficulty.medium,
)
```

**Important:** The correct answer must always be the first element in the answers list — the app shuffles options for display.

### Choosing Difficulty

The question bank supports three difficulties, and you can filter by both difficulty and, in the data, decade:

```dart
enum Difficulty { easy, medium, hard }
```

### Customizing the Theme

Modify `lib/theme/background_theme.dart` to change the gradient:

```dart
static const startAlignment = Alignment.topLeft;
static const endAlignment = Alignment.bottomRight;
```

### Hints

Each question can carry an optional `hint` string. When present it appears in the question screen, and its usage is tracked on the results review.

## Application Flow

```
[Start Screen]
     ↓ (Press "Start")
[Setup Screen]                ← pick difficulty + duration
     ↓ (Press "Start Quiz")
[Question Screen × 10]        ← tap answers, reveal, hints
     ↓ (Answer all questions)
[Result Screen]               ← score + per-question review
     ↓ (Press "Restart")
[Setup Screen]
```

## License

This project is open source and available for educational purposes.
