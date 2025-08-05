import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme_provider.dart';
import '../logic/password_strength_calculator.dart';

class PasswordStrengthScreen extends StatefulWidget {
  const PasswordStrengthScreen({super.key});

  @override
  State<PasswordStrengthScreen> createState() => _PasswordStrengthScreenState();
}

class _PasswordStrengthScreenState extends State<PasswordStrengthScreen> {
  final TextEditingController _passwordController = TextEditingController();
  PasswordStrength _passwordStrength = PasswordStrength.none;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordStrength);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updatePasswordStrength);
    _passwordController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength() {
    final strength = PasswordStrengthCalculator.calculate(_passwordController.text);
    setState(() {
      _passwordStrength = strength;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Strength'),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_paint_rounded),
            onPressed: () {
              final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
              final newTheme = themeProvider.getTheme().brightness == Brightness.light
                  ? ThemeData.dark()
                  : ThemeData.light();
              themeProvider.setTheme(newTheme);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                labelStyle: TextStyle(
                  color: isDark ? Colors.grey[300] : Colors.grey[700],
                ),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _getStrengthEmoji(_passwordStrength),
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 10),
            Text(
              _getStrengthText(_passwordStrength),
              style: theme.textTheme.headlineSmall?.copyWith(
                color: _getStrengthColor(_passwordStrength, isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStrengthEmoji(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.veryWeak:
        return '👎'; // Thumbs down
      case PasswordStrength.weak:
        return '🤔'; // Thinking face
      case PasswordStrength.medium:
        return '👍'; // Thumbs up
      case PasswordStrength.strong:
        return '💪'; // Flexed biceps
      default:
        return '';
    }
  }

  String _getStrengthText(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.veryWeak:
        return 'Very Weak';
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.strong:
        return 'Strong';
      default:
        return 'Enter a password';
    }
  }

  Color _getStrengthColor(PasswordStrength strength, bool isDark) {
    switch (strength) {
      case PasswordStrength.veryWeak:
        return Colors.red;
      case PasswordStrength.weak:
        return Colors.orange;
      case PasswordStrength.medium:
        return Colors.yellow[700]!;
      case PasswordStrength.strong:
        return Colors.green;
      default:
        return isDark ? Colors.grey[400]! : Colors.grey[600]!;
    }
  }
}