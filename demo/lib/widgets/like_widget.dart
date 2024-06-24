import 'package:demo/models/like_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class LikeBottomSheet extends StatefulWidget {
  @override
  _LikeBottomSheetState createState() => _LikeBottomSheetState();
}

class _LikeBottomSheetState extends State<LikeBottomSheet> {
  final List<LikeModel> _likes = [
    LikeModel(
        id: '1',
        username: 'user1',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
    LikeModel(
        id: '2',
        username: 'user2',
        timestamp: DateTime.now().subtract(const Duration(hours: 1))),
    LikeModel(
        id: '3',
        username: 'user3',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    // Add more LikeModel instances as needed
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
                    itemCount: _likes.length,
                    itemBuilder: (context, index) {
                      return _buildLikeItem(_likes[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLikeItem(LikeModel like) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
            'https://via.placeholder.com/150'), // Placeholder avatar URL
      ),
      title: Text(like.username),
      trailing: Text(timeago.format(like.timestamp)),
    );
  }
}
