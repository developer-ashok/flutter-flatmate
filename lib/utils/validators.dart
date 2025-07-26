class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? validateRequired(String? value, [String field = 'This field']) {
    if (value == null || value.isEmpty) return '$field is required';
    return null;
  }

  static String? validateNumber(String? value, [String field = 'This field']) {
    if (value == null || value.isEmpty) return '$field is required';
    if (double.tryParse(value) == null) return '$field must be a number';
    return null;
  }
} 