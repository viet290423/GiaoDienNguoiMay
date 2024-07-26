class PostModel {
  final String image;
  final String caption;
  final String time;
  final String avatar;
  final String name;
  int likes;
  List<String> comments;
  bool isFavorite;

  PostModel({
    required this.image,
    required this.caption,
    required this.time,
    required this.avatar,
    required this.name,
    required this.likes,
    required this.comments,
    required this.isFavorite,
  });

  // Method to convert PostModel to a map
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'caption': caption,
      'time': time,
      'avatar': avatar,
      'name': name,
      'likes': likes,
      'comments': comments,
      'isFavorite': isFavorite,
    };
  }

  // Factory method to create PostModel from a map
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      image: map['image'],
      caption: map['caption'],
      time: map['time'],
      avatar: map['avatar'],
      name: map['name'],
      likes: map['likes'],
      comments: List<String>.from(map['comments']),
      isFavorite: map['isFavorite'],
    );
  }
}
