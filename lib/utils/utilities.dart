class Utils {
  static String getUsername(String email) {

    return "live:${email.split('@')[0]}";

  }
}
