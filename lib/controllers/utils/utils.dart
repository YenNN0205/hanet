// compare only time part of 2 datetime
// return 0 if is equal
// return negative if first is before second
// return positive if firse is after second
int compareTimeOnly(DateTime first, DateTime second) {
  return first
      .copyWith(year: 0, month: 0, day: 0)
      .compareTo(second.copyWith(year: 0, month: 0, day: 0));
}
