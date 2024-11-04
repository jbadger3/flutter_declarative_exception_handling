abstract class DetailedException implements Exception {
  final String title;
  final String message;

  DetailedException({required this.title, required this.message});
}
