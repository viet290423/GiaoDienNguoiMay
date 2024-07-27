import 'dart:async';
import 'dart:convert';
import 'package:demo/app/dimensions.dart';
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

  @override
  void initState() {
    super.initState();
    _updateElapsedTime();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateElapsedTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    _elapsedTimeNotifier.dispose();
    super.dispose();
  }

  void _updateElapsedTime() {
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
        title: Text('Hiển Thị Ảnh'),
      ),
      body: Center(
        child: _buildPost(widget.post.toMap(), 0),
      ),
    );
  }

  Widget _buildPost(Map<String, dynamic> post, int index) {
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
                  backgroundImage: AssetImage(post['avatar']),
                ),
                SizedBox(width: Dimensions.height10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
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
                  widget.post.isFavorite = !widget.post.isFavorite;
                  widget.post.likes += widget.post.isFavorite ? 1 : -1;
                });
              },
              child: Container(
                width: double.infinity,
                height: Dimensions.popularImgSize,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: MemoryImage(Base64Decoder().convert(post['image'])),
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
    return Row(
      children: [
        Icon(
          Icons.thumb_up,
          color: widget.post.isFavorite ? Colors.red : Colors.grey,
        ),
        SizedBox(width: 5),
        Text('${widget.post.likes} likes'),
      ],
    );
  }

  Widget _buildCommentButton(int comments) {
    return Row(
      children: [
        Icon(Icons.comment, color: Colors.grey),
        SizedBox(width: 5),
        Text('$comments comments'),
      ],
    );
  }
}
