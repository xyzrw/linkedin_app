import 'package:linkedin_app/models/user.dart';

class Comment {
  final String text;
  final DateTime postedDate;
  User user;

  Comment({required this.text, required this.user, required this.postedDate});
}
