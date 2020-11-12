class Validator {
  static String nameValidate(String value) {
    if (value.isEmpty) {
      return "Nama tidak boleh kosong";
    }
    if (value.length < 2) {
      return "Nama tidak boleh kurang dari 2 karakter";
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return "Masukan nama yang benar";
    }
    return null;
  }

  static String emailValidate(String value) {
    if (value.isEmpty) {
      return "Email tidak boleh kosong";
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return "Masukan email yang benar";
    }
    return null;
  }

  static String passwordValidate(String value) {
    if (value.isEmpty) {
      return "Password tidak boleh kosong";
    }

    return null;
  }
}
