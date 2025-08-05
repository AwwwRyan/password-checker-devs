
enum PasswordStrength {
  none,
  veryWeak,
  weak,
  medium,
  strong,
}

class PasswordStrengthCalculator {
  static PasswordStrength calculate(String password) {
    if (password.isEmpty) {
      return PasswordStrength.none;
    }

    int score = 0;
    if (password.length >= 8) score++;
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

    if (score <= 2) {
      return PasswordStrength.veryWeak;
    } else if (score <= 3) {
      return PasswordStrength.weak;
    } else if (score <= 4) {
      return PasswordStrength.medium;
    } else {
      return PasswordStrength.strong;
    }
  }
}
