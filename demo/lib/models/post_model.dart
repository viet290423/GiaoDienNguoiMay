class Post {
  String image;
  String avatar;
  String name;
  String time;
  String caption;
  int likes;
  int comments;
  bool isFavorite;

  Post({
    required this.image,
    required this.avatar,
    required this.name,
    required this.time,
    required this.caption,
    required this.likes,
    required this.comments,
    this.isFavorite = false,
  });

  static List<Post> generatePosts() {
    return [
      Post(
        image: 'assets/images/anh1.jpg',
        avatar: 'assets/images/flowers.png',
        name: 'Hoa',
        time: '2 min ago',
        caption: 'Guess where I am??',
        likes: 1200,
        comments: 1200,
      ),
      Post(
        image: 'assets/images/flowers.png',
        avatar: 'assets/images/labubu1.webp',
        name: 'Minh Quan',
        time: '5 min ago',
        caption: 'Just chilling here!',
        likes: 800,
        comments: 500,
      ),
      Post(
        image: 'assets/images/labubu3.jpg',
        avatar: 'assets/images/labubu6.webp',
        name: 'Minh',
        time: '5 min ago',
        caption: 'Just chilling here!',
        likes: 800,
        comments: 500,
      ),
    ];
  }
}
