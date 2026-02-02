class ValidatorUtils {

static bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  return emailRegex.hasMatch(email.trim());
}


static bool isValidPhone(String phone) {
  final phoneRegex = RegExp(r'^\+?[1-9]\d{7,14}$');
  return phoneRegex.hasMatch(phone.trim());
}

}