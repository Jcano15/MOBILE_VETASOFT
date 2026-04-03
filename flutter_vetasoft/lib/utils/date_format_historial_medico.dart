String formatDate(String? date) {
  if (date == null) return 'N/A';

  final d = DateTime.parse(date);
  return '${d.day}/${d.month}/${d.year}';
}