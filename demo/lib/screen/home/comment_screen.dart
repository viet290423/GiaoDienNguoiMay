import 'package:demo/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

import '../../app/dimensions.dart';

class CommentScreen extends StatefulWidget {
  final String userName;
  final String avatarUser;
  final String image;
  final MemoryImage? decodedImage;
  final String time;
  final String caption;
  final int initialLikes;
  final int initialComments;
  final bool initialIsFavorite;
  final List<Post> posts;

  const CommentScreen({
    super.key,
    required this.userName,
    required this.avatarUser,
    required this.image,
    required this.time,
    required this.caption,
    required this.initialLikes,
    required this.initialComments,
    required this.posts,
    required this.initialIsFavorite, 
    this.decodedImage,
  });


  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  // final Map<String, dynamic> infor = {
  //   'name': 'Thảo Nguyên',
  //   'pic': 'assets/images/anh1.jpg',
  //   'like': '1,2k',
  //   'comment': '1,2k',
  //   'isFavorite': false,
  //   'time': '2 min ago',
  //   'avatar': 'assets/images/flowers.png',
  // };
  final List<Map<String, String>> comments = [
    {
      'name': 'Khánh',
      'comment': 'That soo cool!!!!'
    },
    {
      'name': 'Kevin',
      'comment': 'That’s soo beautifull!!! Where is that??'
    }
  ];

  final String userKey = 'iloveyou';
  bool isKeyVerified = false;

  final List<String> emojiList = [
    '😀', '😁', '😂', '😃', '😄', '😅', '😆', '😉', '😊', '😋', 
    '😎', '😍', '😘', '😗', '😙', '😚', '☺', '🙂', '🤗', '🤔',
    '😐', '😑', '😶', '😏', '😒', '😓', '😔', '😕', '😖', '😞',
    '😟', '😢', '😣', '😤', '😥', '😦', '😧', '😨', '😩', '😪',
    '😫', '😬', '😭', '😮', '😯', '😰', '😱', '😲', '😳', '😴',
    '😵', '😡', '😠', '😷', '🤒', '🤕', '🤢', '🤣', '🤠', '🤡',
    '🤥', '🤧', '🤮', '🤫', '🤭', '🧐', '🤓', '🤔', '🤐', '😷',
    '🤕', '🤢', '🤒', '😈', '👿', '👹', '👺', '💀', '👻', '👽',
    '🤖', '💩', '😺', '😸', '😹', '😻', '😼', '😽', '🙀', '😿',
    '😾', '🙈', '🙉', '🙊', '💋', '💌', '💘', '💝', '💖', '💗',
    '💓', '💞', '💕', '💟', '❣', '💔', '❤️', '🧡', '💛', '💚',
    '💙', '💜', '🖤', '💯', '💢', '💥', '💫', '💦', '💨', '🕳',
    '💣', '💬', '👁‍🗨', '🗨', '🗯', '💭', '💤', '👋', '🤚', 
    '🖐', '✋', '🖖', '👌', '✌', '🤞', '🤟', '🤘', '🤙', '🖕',
    '✊', '👊', '🤛', '🤜', '👏', '🙌', '👐', '🤲', '🤝', '🙏',
    '✍', '💅', '🤳', '💪', '🦵', '🦶', '👂', '🦻', '👃', '🧠',
    '🦷', '🦴', '👀', '👁', '👅', '👄', '👶', '🧒', '👦', '👧',
    '🧑', '👱', '👨', '🧔', '👨‍🦰', '👨‍🦱', '👨‍🦳', '👨‍🦲', '👩', '👩‍🦰',
    '👩‍🦱', '👩‍🦳', '👩‍🦲', '👱‍♀️', '👱‍♂️', '🧓', '👴', '👵', '🙍', '🙍‍♂️',
    '🙍‍♀️', '🙎', '🙎‍♂️', '🙎‍♀️', '🙅', '🙅‍♂️', '🙅‍♀️', '🙆', '🙆‍♂️', '🙆‍♀️',
    '💁', '💁‍♂️', '💁‍♀️', '🙋', '🙋‍♂️', '🙋‍♀️', '🧏', '🧏‍♂️', '🧏‍♀️', '🙇',
    '🙇‍♂️', '🙇‍♀️', '🤦', '🤦‍♂️', '🤦‍♀️', '🤷', '🤷‍♂️', '🤷‍♀️', '👨‍⚕️', '👩‍⚕️',
    '👨‍🎓', '👩‍🎓', '👨‍🏫', '👩‍🏫', '👨‍⚖️', '👩‍⚖️', '👨‍🌾', '👩‍🌾', '👨‍🍳', '👩‍🍳',
    '👨‍🔧', '👩‍🔧', '👨‍🏭', '👩‍🏭', '👨‍💼', '👩‍💼', '👨‍🔬', '👩‍🔬', '👨‍💻', '👩‍💻',
    '👨‍🎤', '👩‍🎤', '👨‍🎨', '👩‍🎨', '👨‍✈️', '👩‍✈️', '👨‍🚀', '👩‍🚀', '👨‍🚒', '👩‍🚒',
    '👮', '👮‍♂️', '👮‍♀️', '🕵️', '🕵️‍♂️', '🕵️‍♀️', '💂', '💂‍♂️', '💂‍♀️', '👷',
    '👷‍♂️', '👷‍♀️', '🤴', '👸', '👳', '👳‍♂️', '👳‍♀️', '👲', '🧕', '🤵', '🤵‍♂️',
    '🤵‍♀️', '👰', '👰‍♂️', '👰‍♀️', '🤰', '🤱', '👩‍🍼', '👨‍🍼', '🧑‍🍼', '👼',
    '🎅', '🤶', '🧑‍🎄', '🦸', '🦸‍♂️', '🦸‍♀️', '🦹', '🦹‍♂️', '🦹‍♀️', '🧙',
    '🧙‍♂️', '🧙‍♀️', '🧚', '🧚‍♂️', '🧚‍♀️', '🧛', '🧛‍♂️', '🧛‍♀️', '🧜', '🧜‍♂️',
    '🧜‍♀️', '🧝', '🧝‍♂️', '🧝‍♀️', '🧞', '🧞‍♂️', '🧞‍♀️', '🧟', '🧟‍♂️', '🧟‍♀️',
    '💆', '💆‍♂️', '💆‍♀️', '💇', '💇‍♂️', '💇‍♀️', '🚶', '🚶‍♂️', '🚶‍♀️', '🏃',
    '🏃‍♂️', '🏃‍♀️', '💃', '🕺', '🕴', '👯', '👯‍♂️', '👯‍♀️', '🧖', '🧖‍♂️',
    '🧖‍♀️', '🧗', '🧗‍♂️', '🧗‍♀️', '🤺', '🏇', '⛷', '🏂', '🏌️', '🏌️‍♂️',
    '🏌️‍♀️', '🏄', '🏄‍♂️', '🏄‍♀️', '🚣', '🚣‍♂️', '🚣‍♀️', '🏊', '🏊‍♂️', '🏊‍♀️',
    '⛹️', '⛹️‍♂️', '⛹️‍♀️', '🏋️', '🏋️‍♂️', '🏋️‍♀️', '🚴', '🚴‍♂️', '🚴‍♀️', '🚵',
    '🚵‍♂️', '🚵‍♀️', '🤸', '🤸‍♂️', '🤸‍♀️', '🤼', '🤼‍♂️', '🤼‍♀️', '🤽', '🤽‍♂️',
    '🤽‍♀️', '🤾', '🤾‍♂️', '🤾‍♀️', '🤹', '🤹‍♂️', '🤹‍♀️', '🧘', '🧘‍♂️', '🧘‍♀️',
    '🛀', '🛌', '🧑‍🤝‍🧑', '👭', '👫', '👬', '💏', '👩‍❤️‍💋‍👨', '👨‍❤️‍💋‍👨', '👩‍❤️‍💋‍👩',
    '💑', '👩‍❤️‍👨', '👨‍❤️‍👨', '👩‍❤️‍👩', '👪', '👨‍👩‍👦', '👨‍👩‍👧', '👨‍👩‍👧‍👦', '👨‍👩‍👦‍👦', '👨‍👩‍👧‍👧',
    '👨‍👨‍👦', '👨‍👨‍👧', '👨‍👨‍👧‍👦', '👨‍👨‍👦‍👦', '👨‍👨‍👧‍👧', '👩‍👩‍👦', '👩‍👩‍👧', '👩‍👩‍👧‍👦', '👩‍👩‍👦‍👦', '👩‍👩‍👧‍👧',
    '👫', '👬', '👭', '💪', '👈', '👉', '👆', '👇', '✊', '👊', 
    '🤛', '🤜', '🤞', '✌', '🤟', '🤘', '👌', '👈', '👉', '👆',
    '👇', '🖖', '🤙', '💪', '🖐', '✋', '🖖', '👋', '🤙', '✌',
    '🤟', '🤘', '🤞', '🤛', '🤜', '🤚', '👐', '🙌', '👏', '🙏'
];

String encodeEmoji(String text) {
  final buffer = StringBuffer();
  final random = Random();

  for (var char in text.codeUnits) {
    final hash = sha256.convert(utf8.encode(char.toString()));
    final index = hash.bytes.reduce((a, b) => a + b) % emojiList.length;
    buffer.write(emojiList[index]);
  }
  return buffer.toString();
}

String decodeEmoji(String encodedText) {
  try {
    final buffer = StringBuffer();
    for (var emoji in encodedText.split('')) {
      final index = emojiList.indexOf(emoji);
      final charCode = (index - (index % 32)) + 32; // Adjust index to charCode
      buffer.write(String.fromCharCode(charCode));
    }
    final decryptedText = buffer.toString();
    return decryptedText;
  } catch (e) {
    return 'error';
  }
}

void verifyUserKey(BuildContext context, Function onSuccess) {
  if (isKeyVerified) {
    onSuccess();
  } else {
    final keyController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Nhập Intimate Key <3'),
        content: TextField(
          controller: keyController,
          decoration: InputDecoration(hintText: 'Key'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, keyController.text);
            },
            child: Text('Xác nhận'),
          ),
        ],
      ),
    ).then((result) {
      if (result == userKey) {
        setState(() {
          isKeyVerified = true;
        });
        onSuccess();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Key không đúng, vui lòng liên hệ với chủ bài đăng.')),
        );
      }
    });
  }
}

void addComment(String username, String comment) {
  setState(() {
    comments.add({'name': username, 'comment': comment});
  });
}

@override
Widget build(BuildContext context) {
  int likes = widget.initialLikes;
  int comment = widget.initialComments;
  bool isFavorite = widget.initialIsFavorite;

  // @override
  // void initState() {
  //   super.initState();
  //   likes = widget.initialLikes;
  //   comment = widget.initialComments;
  //   isFavorite = widget.initialIsFavorite;
  // }

  final commentController = TextEditingController();
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(CupertinoIcons.back, color: Colors.black, size: Dimensions.iconSize24 * 2,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Padding(
        padding: EdgeInsets.only(top: Dimensions.height10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: Dimensions.radius20,
              backgroundImage: AssetImage(widget.avatarUser),
            ),
            SizedBox(width: Dimensions.height10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.height20,
                  child: Text(
                    widget.userName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.font16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20 + 2,
                  child: Text(
                    widget.time,
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
      ),
    ),
    body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.height10),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: SizedBox(
                    width: 313,
                    height: 30,
                    child: Text(
                      widget.caption,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                      likes += isFavorite ? 1 : -1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.infinity,
                      height: Dimensions.popularImgSize,
                      decoration: BoxDecoration(
                        image: widget.decodedImage != null
                            ? DecorationImage(
                                image: widget.decodedImage!,
                                fit: BoxFit.fill,
                              )
                            : DecorationImage(
                                image: AssetImage(widget.image),
                                fit: BoxFit.fill,
                              ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                          likes += isFavorite ? 1 : -1;
                        });
                      },
                      child: SizedBox(
                        width: 150,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.black,
                            ),
                            SizedBox(width: Dimensions.width10 / 2),
                            Text(
                              '$likes',
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
                    ),
                    SizedBox(
                      width: 150,
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
                            '$comment',
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
                  ],
                ),
                const Divider(),
                ...comments.map((comment) {
                  return CommentItem(
                    username: comment['name']!,
                    originalComment: comment['comment']!,
                    encodeEmoji: encodeEmoji,
                    decodeEmoji: decodeEmoji,
                    verifyUserKey: verifyUserKey,
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Nhập comment của bạn',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    // Khi nhấn vào ô nhập comment, bàn phím sẽ hiển thị
                    // FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (commentController.text.isNotEmpty) {
                    addComment('User', commentController.text);
                    commentController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}

class CommentItem extends StatefulWidget {
  final String username;
  final String originalComment;
  final String Function(String) encodeEmoji;
  final String Function(String) decodeEmoji;
  final void Function(BuildContext, Function) verifyUserKey;

  const CommentItem({
    required this.username,
    required this.originalComment,
    required this.encodeEmoji,
    required this.decodeEmoji,
    required this.verifyUserKey,
  });

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool isDecoded = false;
  bool isLiked = false;
  late String currentComment;

  @override
  void initState() {
    super.initState();
    currentComment = widget.encodeEmoji(widget.originalComment);
  }

  void toggleComment() {
    widget.verifyUserKey(context, () {
      setState(() {
        if (isDecoded) {
          currentComment = widget.encodeEmoji(widget.originalComment);
        } else {
          currentComment = widget.originalComment;
        }
        isDecoded = !isDecoded;
        isLiked = !isLiked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            child: Text(widget.username[0]),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    currentComment,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(
              isLiked ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
              color: Colors.black,
            ),
            onPressed: toggleComment,
          ),
        ],
      ),
    );
  }
}

