# Flags Quiz App in Flutter - Version 2

In Version 2 of the Flags Quiz App, we enhance the functionality by adding the `shared_preferences` plugin. This addition allows the app to store data locally on the user's device, enabling persistent state management. With `shared_preferences`, we can save and retrieve user data such as high scores, user preferences, and quiz progress.

## Key Enhancements with `shared_preferences`

### High Scores
- **Description**: Store and display the highest score achieved by the user.
- **Implementation**: After each quiz, the app checks if the current score is higher than the stored high score. If it is, the high score is updated.
- **Benefit**: Provides a competitive element, motivating users to improve their scores.

### Quiz Progress
- **Description**: Save the current progress of an ongoing quiz.
- **Implementation**: The app saves the current question index and the score whenever the user answers a question. When the app is reopened, it can resume from where the user left off.
- **Benefit**: Enhances user experience by allowing them to continue their quiz without losing progress.

### User Preferences
- **Description**: Store user settings such as preferred language or theme (light/dark mode).
- **Implementation**: Preferences are saved and retrieved using `shared_preferences`. For example, if the user selects a dark theme, this preference is stored and applied whenever the app is launched.
- **Benefit**: Personalizes the app experience for individual users.

## How `shared_preferences` Enhances the App

1. **Persistent High Scores**:
   - Keeps track of the highest score achieved by the user.
   - Provides a record of the user's performance over time.
   - Example: Displaying the high score on the home screen to encourage users to beat their previous best.

2. **Resume Quiz Functionality**:
   - Saves the current state of the quiz, including the question index and the user's score.
   - Allows users to exit and return to the app without losing their progress.
   - Example: Showing a "Continue Quiz" option on the home screen if there is a saved quiz state.

3. **Personalized User Experience**:
   - Stores user preferences like theme, language, and notification settings.
   - Applies these preferences every time the app is launched.
   - Example: Automatically switching to the dark theme if the user had selected it previously.

## Implementation Overview

### Adding `shared_preferences` Plugin

To add `shared_preferences`, include it in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.0.6
```

### Storing and Retrieving Data

Here's a conceptual overview of how you might use `shared_preferences` in the app:

- **Storing High Score**:
  ```dart
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('high_score', currentScore);
  ```

- **Retrieving High Score**:
  ```dart
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? highScore = prefs.getInt('high_score');
  ```

- **Saving Quiz Progress**:
  ```dart
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('current_question', currentQuestionIndex);
  await prefs.setInt('current_score', currentScore);
  ```

- **Retrieving Quiz Progress**:
  ```dart
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? currentQuestionIndex = prefs.getInt('current_question');
  int? currentScore = prefs.getInt('current_score');
  ```

- **Storing User Preferences**:
  ```dart
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('dark_mode', isDarkMode);
  ```

- **Retrieving User Preferences**:
  ```dart
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isDarkMode = prefs.getBool('dark_mode');
  ```
