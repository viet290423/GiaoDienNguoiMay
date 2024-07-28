import 'dart:async';

import 'package:demo/app/dimensions.dart';
import 'package:demo/models/post_model.dart';
import 'package:flutter/material.dart';

class PostTimeWidget extends StatefulWidget {
  final Post post;

  const PostTimeWidget({Key? key, required this.post}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostTimeWidget> {
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
      _elapsedTimeNotifier.value = '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      _elapsedTimeNotifier.value = '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      _elapsedTimeNotifier.value = '${difference.inHours} hour ago';
    } else if (difference.inDays < 7) {
      _elapsedTimeNotifier.value = '${difference.inDays} day ago';
    } else {
      _elapsedTimeNotifier.value =
          '${(difference.inDays / 7).floor()} week ago';
    }
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 30), (timer) {
      _updateElapsedTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
