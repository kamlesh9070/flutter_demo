import 'dart:io';


class AppUtils {
  static bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  static bool isNullOrEmpty(String str) {
    return str == null || str.trim().isEmpty;
  }

}
