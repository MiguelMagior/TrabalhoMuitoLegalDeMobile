class Workout {
  final DateTime date;
  final String title;
  bool isCompleted;
  final bool isRest;

  Workout({
    required this.date,
    required this.title,
    required this.isCompleted,
    this.isRest = false,
  });
}