import 'package:linkedin_app/models/comment.dart';
import 'package:linkedin_app/models/user.dart';

class Post {
  String description;
  String? imagePath;
  User user;
  int likes;
  bool liked;
  final DateTime createdDate;
  final List<Comment> comments;

  Post({
    List<Comment>? comments,
    required this.description,
    required this.createdDate,
    this.imagePath,
    required this.likes,
    required this.user,
    this.liked = false,
  }) : comments = comments ?? [];

  void addComment(Comment comment) {
    comments.add(comment);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Post &&
        createdDate == other.createdDate &&
        user.name == other.user.name;
  }

  @override
  int get hashCode => Object.hash(createdDate, user.name);
}
