import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentBottomSheet extends StatefulWidget {
  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  final List<CommentModel> _comments = [
    CommentModel(
        id: '1',
        username: 'user1',
        content: 'Nice post!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
    CommentModel(
        id: '2',
        username: 'user2',
        content: 'Great picture!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1))),
    CommentModel(
        id: '3',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '4',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '5',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '6',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '7',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '8',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '9',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '10',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '11',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '12',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '13',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    CommentModel(
        id: '14',
        username: 'user3',
        content: 'Awesome!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      padding: MediaQuery.of(context).viewInsets,
      child: DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 5.0,
                  width: 50.0,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      return _buildCommentItem(_comments[index]);
                    },
                  ),
                ),
                const Divider(height: 1.0),
                _buildCommentInput(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCommentItem(CommentModel comment) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, right: 28, top: 15, bottom: 15),
      child: Container(
        width: 370,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 30,
              offset: Offset(-5, 15),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, top: 12, right: 15, bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Placeholder avatar URL
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        comment.username,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        timeago.format(comment.timestamp),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 258,
                    child: AutoSizeText(
                      comment.content,
                      maxLines: 3, // Đặt số dòng tối đa bạn muốn hiển thị
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
        ),
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 50.0,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/150'), // Placeholder avatar URL
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: 'Comment...',
                border: InputBorder.none,
              ),
              onTap: () {},
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_commentController.text.isNotEmpty) {
                setState(() {
                  _comments.add(CommentModel(
                    id: DateTime.now().toString(),
                    username: 'current_user',
                    content: _commentController.text,
                    timestamp: DateTime.now(),
                  ));
                  _commentController.clear();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
