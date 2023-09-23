extension EnumToFirstUpperCase on Enum {
  String toFirstUpperCase() {
    String firstLetter = name[0].toUpperCase();
    String restOfString = name.substring(1);
    return '$firstLetter$restOfString';
  }
}

extension EnumFirstUpperCase on String {
  String enumUpperCase() {
    return split('.')[1].toUpperCase();
  }
}

extension DateString on DateTime? {
  String dateString() {
    String result = "${this?.day} ${_month(this?.month)} ${this?.year}";

    return result;
  }

  String dateStript() {
    String result = "${this?.day}-${_month(this?.month)}-${this?.year}";

    return result;
  }
}

String _month(int? month) {
  switch (month) {
    case 1:
      return "Januari";
    case 2:
      return "Februari";
    case 3:
      return "Maret";
    case 4:
      return "April";
    case 5:
      return "Mei";
    case 6:
      return "Juni";
    case 7:
      return "Juli";
    case 8:
      return "Agustus";
    case 9:
      return "September";
    case 10:
      return "Oktober";
    case 11:
      return "November";
    case 12:
      return "Desember";
    default:
      return "";
  }
}
