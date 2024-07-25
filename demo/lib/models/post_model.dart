class PostModel {
  final String image;
  final String avatar;
  final String name;
  final String time;
  final String caption;
  int likes;
  List<String> comments;
  bool isFavorite;

  PostModel({
    required this.image,
    required this.avatar,
    required this.name,
    required this.time,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.isFavorite,
  });
}
