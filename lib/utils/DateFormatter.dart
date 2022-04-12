class DateUtil {

  static String formatDateTime(DateTime date) {
    return date.year.toString() + "-" + date.month.toString().padLeft(2, '0') + "-" + date.day.toString().padLeft(2, '0');
  }

  static String formatDateTimeToPrint(DateTime date) {
    return date.day.toString().padLeft(2, '0') + "." + date.month.toString().padLeft(2, '0') + "." +  date.year.toString();
  }

}