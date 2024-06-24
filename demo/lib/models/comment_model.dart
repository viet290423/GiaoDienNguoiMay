class CommentModel {
  final String id;
  final String username;
  final String content;
  final DateTime timestamp;

  CommentModel({
    required this.id,
    required this.username,
    required this.content,
    required this.timestamp,
  });
}
