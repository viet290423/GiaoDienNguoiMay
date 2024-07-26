import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final Map<String, dynamic> infor = {
    'name': 'Thảo Nguyên',
    'pic': 'assets/images/anh1.jpg',
    'like': '1,2k',
    'comment': '1,2k',
    'isFavorite': false,
    'time': '2 min ago',
    'avatar': 'assets/images/flowers.png',
  };

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
  final commentController = TextEditingController();

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(infor['avatar']),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
                child: Text(
                  infor['name'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                child: Text(
                  infor['time'],
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
    body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      infor['isFavorite'] = !infor['isFavorite'];
                      infor['like'] = infor['isFavorite'] ? '1,3k' : '1,2k';
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(infor['pic']),
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
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            infor['isFavorite']
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () {
                            setState(() {
                              infor['isFavorite'] = !infor['isFavorite'];
                              infor['like'] = infor['isFavorite'] ? '1,3k' : '1,2k';
                            });
                          },
                        ),
                        Text(infor['like']),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.chat_bubble,
                          color: Colors.black,
                        ),
                        Text(infor['comment']),
                      ],
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
          Column(
            children: [
              IconButton(
                icon: const Icon(
                  CupertinoIcons.chat_bubble,
                  color: Colors.black,
                ),
                onPressed: toggleComment,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
