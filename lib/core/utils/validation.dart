String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Invalid email address';
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }
  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return 'Invalid phone number';
  }
  return null;
}

String? validateText(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }

  return null;
}
