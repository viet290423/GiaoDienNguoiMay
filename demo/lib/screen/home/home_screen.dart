import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:demo/app/dimensions.dart';
import 'package:demo/controller/post_controller.dart';
import 'package:demo/models/post_model.dart';
import 'package:demo/screen/account/userposts_screen.dart';
import 'package:demo/screen/home/comment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/screen/add/add_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  List<Post> get filteredPosts {
    final posts = Provider.of<PostController>(context).posts;
    if (searchQuery.isEmpty) {
      return posts;
    } else {
      return posts
          .where((post) =>
              post.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'FUZZYSNAP',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: CustomSearch(
                          posts: Provider.of<PostController>(context,
                                  listen: false)
                              .posts));
                },
                icon: Icon(
                  Icons.search,
                  size: 30,
                )),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: Consumer<PostController>(
                    builder: (context, postController, child) {
                      return PageView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: filteredPosts.length,
                        itemBuilder: (context, index) {
                          final post = filteredPosts[index];
                          return _buildPost(post, index);
                        },
                      );
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

  Widget _buildPost(Post post, int index) {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.height30,
          bottom: Dimensions.height45,
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
                  backgroundImage: AssetImage(post.avatar),
                ),
                SizedBox(width: Dimensions.height10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.height20,
                      child: Text(
                        post.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.font16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                      child: Text(
                        post.time,
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
                  post.isFavorite = !post.isFavorite;
                  post.likes += post.isFavorite ? 1 : -1;
                });
              },
              child: Container(
                width: double.infinity,
                height: Dimensions.popularImgSize,
                decoration: ShapeDecoration(
                  image: post.decodedImage != null
                      ? DecorationImage(
                          image: post.decodedImage!,
                          fit: BoxFit.fill,
                        )
                      : DecorationImage(
                          image: AssetImage(post.image),
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
                post.caption,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLikeButton(post),
                _buildCommentButton(context, post),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLikeButton(Post post) {
    return GestureDetector(
      onTap: () {
        setState(() {
          post.isFavorite = !post.isFavorite;
          post.likes += post.isFavorite ? 1 : -1;
        });
      },
      child: Container(
        // width: 150,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              post.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: post.isFavorite ? Colors.red : Colors.black,
            ),
            SizedBox(width: Dimensions.width10 / 2),
            Text(
              '${post.likes}',
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

  Widget _buildCommentButton(BuildContext context, Post post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommentScreen(
                      userName: post.name,
                      avatarUser: post.avatar,
                      image: post.image,
                      time: post.time,
                      caption: post.caption,
                      initialComments: post.comments,
                      posts: filteredPosts,
                      initialLikes: post.likes,
                      initialIsFavorite: post.isFavorite,
                      decodedImage: post.decodedImage,
                    )));
      },
      child: SizedBox(
        // width: 150,
        height: 40,
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
              '${post.comments}',
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
  final List<Post> posts;

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
    final List<Post> filteredPosts = posts
        .where((post) => post.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(post.avatar),
          ),
          title: Text(post.name),
          onTap: () {
            // Khi bấm vào tên của người đăng, hiển thị các bài đăng của họ
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPostsScreen(
                  userName: post.name,
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
    final List<Post> filteredPosts = posts
        .where((post) => post.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(post.avatar),
          ),
          title: Text(post.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPostsScreen(
                  userName: post.name,
                  posts: posts,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
