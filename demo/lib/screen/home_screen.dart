import 'package:demo/app/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:demo/screen/add_screen.dart';
import 'package:demo/widgets/comment_widget.dart';
import 'package:demo/widgets/like_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFavorite = false;
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  // Danh sách bài đăng
  final List<Map<String, dynamic>> posts = [
    {
      'image': 'assets/images/anh1.jpg',
      'avatar': 'assets/images/flowers.png',
      'name': 'Hoa',
      'time': '2 min ago',
      'caption': 'Guess where I am??',
      'likes': 1200,
      'comments': 1200,
      'isFavorite': false,
    },
    {
      'image': 'assets/images/anh1.jpg',
      'avatar': 'assets/images/flowers.png',
      'name': 'Minh Thu',
      'time': '5 min ago',
      'caption': 'Just chilling here!',
      'likes': 800,
      'comments': 500,
      'isFavorite': false,
    },
    {
      'image': 'assets/images/anh1.jpg',
      'avatar': 'assets/images/flowers.png',
      'name': 'Minh',
      'time': '5 min ago',
      'caption': 'Just chilling here!',
      'likes': 800,
      'comments': 500,
      'isFavorite': false,
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    if (searchQuery.isEmpty) {
      return posts;
    } else {
      return posts
          .where((post) => post['name']
          .toLowerCase()
          .contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.height45, left: Dimensions.width10, right: Dimensions.width10),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      final post = filteredPosts[index];
                      return _buildPost(post, index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          child: const SizedBox(
            child: Text(
              'FUZZY SNAP \nWELCOME BACK',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 + 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    print('Searching for: $value');
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.search, size: 30),
                onPressed: () {
                  setState(() {
                    searchQuery = searchController.text;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPost(Map<String, dynamic> post, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height20, left: Dimensions.width10, right: Dimensions.width10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 23, top: 20, right: 23, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(post['avatar']),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 28,
                      child: Text(
                        post['name'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 18,
                      child: Text(
                        post['time'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  posts[index]['isFavorite'] = !posts[index]['isFavorite'];
                  posts[index]['likes'] += posts[index]['isFavorite'] ? 1 : -1;
                });
              },
              child: Container(
                width: double.infinity,
                height: 330,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(post['image']),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 313,
              height: 30,
              child: Text(
                post['caption'],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLikeButton(index),
                _buildCommentButton(post['comments']),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildLikeButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          posts[index]['isFavorite'] = !posts[index]['isFavorite'];
          posts[index]['likes'] += posts[index]['isFavorite'] ? 1 : -1;
        });
      },
      child: Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              posts[index]['isFavorite'] ? Icons.favorite : Icons.favorite_border,
              color: posts[index]['isFavorite'] ? Colors.red : Colors.white,
            ),
            const SizedBox(width: 5),
            Text(
              '${posts[index]['likes']}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCommentButton(int comments) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => CommentBottomSheet(),
        );
      },
      child: Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.comment,
              color: Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '$comments',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
