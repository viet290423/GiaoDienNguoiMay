import 'dart:async';
import 'package:demo/app/dimensions.dart';
import 'package:demo/screen/home/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/models/post_model.dart';

class HienThi extends StatefulWidget {
  final Post post;

  const HienThi({super.key, required this.post});

  @override
  _HienThiState createState() => _HienThiState();
}

class _HienThiState extends State<HienThi> {
  late Timer _timer;
  final ValueNotifier<String> _elapsedTimeNotifier = ValueNotifier<String>('');
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _updateElapsedTime();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateElapsedTime());
  }

  @override
  void dispose() {
    _isDisposed = true;
    _timer.cancel();
    _elapsedTimeNotifier.dispose();
    super.dispose();
  }

  void _updateElapsedTime() {
    if (_isDisposed) return;

    final now = DateTime.now();
    final postTime = DateTime.parse(widget.post.time);
    final difference = now.difference(postTime);

    if (difference.inSeconds < 60) {
      _elapsedTimeNotifier.value = '${difference.inSeconds} giây trước';
    } else if (difference.inMinutes < 60) {
      _elapsedTimeNotifier.value = '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      _elapsedTimeNotifier.value = '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      _elapsedTimeNotifier.value = '${difference.inDays} ngày trước';
    } else {
      _elapsedTimeNotifier.value =
          '${(difference.inDays / 7).floor()} tuần trước';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post successful',
          style: TextStyle(
            color: Colors.black,
            fontSize: Dimensions.font20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            size: Dimensions.iconSize16 * 2,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScreen()),
              (Route<dynamic> route) => false,
            ); // Quay về trang trước đó
          },
        ),
      ),
      body: Center(
        child: _buildPost(widget.post),
      ),
    );
  }

  Widget _buildPost(Post post) {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.height30,
          bottom: Dimensions.height45,
          left: Dimensions.width10,
          right: Dimensions.width10),
      width: double.infinity,
      height: 600,
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
                      child: ValueListenableBuilder<String>(
                        valueListenable: _elapsedTimeNotifier,
                        builder: (context, elapsedTime, child) {
                          return Text(
                            elapsedTime,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.font12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        },
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
                  image: DecorationImage(
                    image: post.decodedImage!,
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
                _buildCommentButton(post),
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

  Widget _buildCommentButton(Post post) {
    return SizedBox(
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
    );
  }
}
