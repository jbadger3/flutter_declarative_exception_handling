abstract class DetailedException implements Exception {
  final String title;
  final String message;

  DetailedException({required this.title, required this.message});

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}
