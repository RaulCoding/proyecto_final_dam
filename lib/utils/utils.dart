class Utils {
  static bool esCorreoValido(String correo) {
  final regexCorreo = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return regexCorreo.hasMatch(correo);
}
}