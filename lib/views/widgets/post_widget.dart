import 'package:flutter/material.dart';
import 'package:linkedin_app/models/post.dart';
import 'package:linkedin_app/utils/consts.dart';
import 'package:linkedin_app/viewmodels/post_viewmodel.dart';
import 'package:linkedin_app/views/post_view.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final PostViewmodel postViewModel;
  const PostWidget({
    super.key,
    required this.post,
    required this.postViewModel,
  });
  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late Post _post;
  TextSpan _textspan(String text, VoidCallback onTap, String endText) =>
      TextSpan(
        text: text,
        style: TextStyle(color: Colors.black),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                endText,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );

  // Expand or minimize text content
  TextSpan _truncateTextSpan(String text, bool status, VoidCallback onTap) {
    if (status) {
      return _textspan('${text.substring(0, 120)}... ', onTap, 'see more');
    }
    if (!status && text.length > 120) {
      return _textspan('$text... ', onTap, 'see less');
    }
    return TextSpan(text: text, style: TextStyle(color: Colors.black));
  }

  late bool truncateText;

  // Returns a formatted string representing the time difference for posts
  String getDateDifference(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays < 1) {
      return '1d';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).floor()}w';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).floor()}m';
    } else {
      return '${(diff.inDays / 365).floor()}y';
    }
  }

  // Button widget that appears below the post content(Like, comment ...)
  Widget postButton(String name, Icon icon, {Function()? onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(10),
          child: Padding(padding: const EdgeInsets.all(5.0), child: icon),
        ),
        Text(name),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _post = widget.post;
    truncateText = _post.description.length > 120;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // User profile pic, name and description
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.asset(
                _post.user.imagePath,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            _post.user.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_post.user.description, overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  Text('${getDateDifference(_post.createdDate)}   '),
                  Icon(size: 15, Icons.public),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        // Post description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Text.rich(
              _truncateTextSpan(
                _post.description,
                truncateText,
                () => setState(() {
                  truncateText = !truncateText;
                }),
              ),
            ),
          ),
        ),
        // Post image
        if (_post.imagePath != null)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [Center(child: Image.asset(_post.imagePath!))],
            ),
          ),
        //Likes and comments
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    SizedBox(
                      height: 20,
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.thumb_up_sharp,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      _post.likes.toString(),
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Text(
                  '${_post.comments.length} comments',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Divider(indent: 20, endIndent: 20),
        ),
        //Buttons list below the post
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postButton(
                'Like',
                Icon(
                  Icons.thumb_up_sharp,
                  color: !_post.liked ? Colors.grey.shade800 : Colors.blue,
                ),
                onTap: () => widget.postViewModel.likePost(_post),
              ),
              postButton(
                'Comment',
                Icon(Icons.comment, color: Colors.grey.shade800),
                onTap:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PostView(post: _post),
                      ),
                    ),
              ),
              postButton(
                'Repost',
                Icon(Icons.repeat, color: Colors.grey.shade800),
              ),
              postButton('Send', Icon(Icons.send, color: Colors.grey.shade800)),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
