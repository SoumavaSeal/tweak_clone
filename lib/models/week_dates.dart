class WeekDates {
  List<DateTime> generateDates(DateTime date) {
    List<DateTime> week = [];

    DateTime first =
        date.subtract(Duration(days: date.weekday - 1));

    for (int i = 0; i < 7; i++) {
      week.add(DateTime(first.year, first.month, first.day));
      first = first.add(const Duration(days: 1));
    }

    return week;
  }

    List<DateTime> PrevDates(DateTime first) {

    first = first.subtract(const Duration(days: 7));

    List<DateTime> week = [];

    for (int i = 0; i < 7; i++) {
      week.add(DateTime(first.year, first.month, first.day));
      first = first.add(const Duration(days: 1));
    }

    return week;
  }

  List<DateTime> NextDates(DateTime first) {

    first = first.add(const Duration(days: 7));

    List<DateTime> week = [];

    for (int i = 0; i < 7; i++) {
      week.add(DateTime(first.year, first.month, first.day));
      first = first.add(const Duration(days: 1));
    }

    return week;
  }
}
