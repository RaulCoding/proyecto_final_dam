class Utils {
  static bool isValidEmail(String correo) {
  final regexCorreo = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return regexCorreo.hasMatch(correo);
}
  String? extractErrorCode(String errorMessage) {
    int startIndex = errorMessage.indexOf("[");
    int endIndex = errorMessage.indexOf("]");

    if (startIndex != -1 && endIndex != -1) {
      return errorMessage.substring(startIndex + 1, endIndex);
    } else {
      return "";
    }
  }
}