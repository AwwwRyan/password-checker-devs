Build a Flutter application that evaluates password strength using regular expressions and visually represents the strength using emojis

Key Features:

Password strength evaluation logic using multiple regex patterns to check for:

Minimum length

Uppercase and lowercase characters

Numbers

Special characters

A visual indicator using emoji-based hand gestures that update live as the user types in the password field.

Ability for users to customize the theme from a range of color palettes (light/dark modes, accent colors, etc.).

Smooth UI animations when changing themes or password strength.

Tech Stack & Libraries (Flutter):

provider or riverpod for state management (you can choose based on preference)

flutter_hooks for cleaner widget logic (optional)

shared_preferences to persist theme preferences

UI Guidelines:

Follow Material Design 3 (Flutter’s M3) with modern UI elements, soft shadows, and rounded corners.

Use responsive layout to support all screen sizes.

Include a theme selector screen/modal with multiple prebuilt color schemes.

Input box should have animated validation feedback (shake on invalid input, glow on strong password).

App Folder Structure (Industry Standard):

bash
Copy
Edit
lib/
├── core/ # Constants, theming, and shared utilities
│ ├── constants/
│ ├── theme/
│ └── utils/
├── data/ # Regex patterns and potential service layer
│ └── models/
├── features/ # Main app features (password evaluator)
│ ├── password_strength/
│ │ ├── presentation/ # UI widgets, screens
│ │ ├── logic/ # Regex logic, strength scoring
│ │ └── provider/ # State management
└── main.dart # App entry point
