/// Validates the city input string.
///
/// This function checks if the provided city name is valid. A valid city name:
/// - Is not null or empty.
/// - Does not contain any numbers.
///
/// Returns a string with an error message if the input is invalid, or null if the input is valid.
String? validateCityInput(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'City name cannot be empty';
  }
  if (RegExp(r'\d').hasMatch(value)) {
    return 'City name cannot contain numbers';
  }
  return null;
}
