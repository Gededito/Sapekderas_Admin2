class DifferentTime {
  static String diff(DateTime dateTime, {bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(dateTime);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} tahun';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 tahun' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 30).floor()} bulan';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 bulan' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} minggu yang lalu';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 minggu yang lalu' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 hari yang lalu' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 jam yang lalu' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} menit yang lalu';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 menit yang lalu' : 'A minute ago';
    } else {
      return 'Online';
    }
  }
}
