import 'package:demo/app/dimensions.dart';
import 'package:demo/screen/account/userposts_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/screen/add/add_screen.dart';
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
          .where((post) =>
          post['name'].toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: Dimensions.width30),
          child: Text(
            'FUZZYSNAP',
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.font20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Dimensions.width30),
            child: IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: CustomSearch(posts: posts));
                },
                icon: Icon(
                  Icons.search,
                  size: Dimensions.iconSize24 + 6,
                )),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                // top: Dimensions.height45,
                left: Dimensions.width10,
                right: Dimensions.width10),
            child: Column(
              children: [
                // _buildHeader(),
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
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

  Widget _buildPost(Map<String, dynamic> post, int index) {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.height30,
          bottom: Dimensions.height45 + 20,
          left: Dimensions.width10,
          right: Dimensions.width10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius30),
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
        padding: EdgeInsets.only(
            left: Dimensions.width20,
            top: Dimensions.height20,
            right: Dimensions.width20,
            bottom: Dimensions.height10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: Dimensions.radius20,
                  backgroundImage: AssetImage(post['avatar']),
                ),
                SizedBox(width: Dimensions.height10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      // width: 200,
                      height: Dimensions.height20,
                      child: Text(
                        post['name'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.font16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      // width: 100,
                      height: Dimensions.height20,
                      child: Text(
                        post['time'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.font12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Dimensions.height30),
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  posts[index]['isFavorite'] = !posts[index]['isFavorite'];
                  posts[index]['likes'] += posts[index]['isFavorite'] ? 1 : -1;
                });
              },
              child: Container(
                width: double.infinity,
                height: Dimensions.popularImgSize,
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
        // decoration: BoxDecoration(
        //   color: Colors.black,
        //   borderRadius: BorderRadius.circular(30),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              posts[index]['isFavorite']
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: posts[index]['isFavorite'] ? Colors.red : Colors.black,
            ),
            SizedBox(width: Dimensions.width10 / 2),
            Text(
              '${posts[index]['likes']}',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.font16,
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
        // decoration: BoxDecoration(
        //   color: Colors.black,
        //   borderRadius: BorderRadius.circular(30),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.chat_bubble,
              color: Colors.black,
            ),
            SizedBox(
              width: Dimensions.width10 / 2,
            ),
            Text(
              '$comments',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.font16,
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

class CustomSearch extends SearchDelegate {
  final List<Map<String, dynamic>> posts;

  CustomSearch({required this.posts});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Map<String, dynamic>> filteredPosts = posts
        .where((post) => post['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(post['avatar']),
          ),
          title: Text(post['name']),
          onTap: () {
            // Khi bấm vào tên của người đăng, hiển thị các bài đăng của họ
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPostsScreen(
                  userName: post['name'],
                  posts: posts,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Map<String, dynamic>> filteredPosts = posts
        .where((post) => post['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(post['avatar']),
          ),
          title: Text(post['name']),
          onTap: () {
            query = post['name'];
            showResults(context);
          },
        );
      },
    );
  }
}

