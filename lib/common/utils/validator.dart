// check input is correct email
bool checkStringIsEmail(String? input) {
  if (input == null || input.isEmpty) return false;
  // REGEX
  String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
  return RegExp(regexEmail).hasMatch(input);
}

/// check input length
bool checkStringLength(String? input, int length) {
  if (input == null || input.isEmpty) return false;
  return input.length >= length;
}
