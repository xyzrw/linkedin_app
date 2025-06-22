import 'package:linkedin_app/models/comment.dart';
import 'package:linkedin_app/models/post.dart';
import 'package:linkedin_app/utils/data.dart';

class PostService {
  Future<List<Post>> fetchPosts() async {
    // Simulating network request
    await Future.delayed(Duration(seconds: 2));
    return Data.posts;
  }

  //Fetching random comments for posts
  List<Comment> fetchRandomComments(int size) {
    final comments = List<Comment>.from(Data.comments);
    comments.shuffle();

    return size < comments.length
        ? comments.take(size).toList()
        : comments.take(comments.length).toList();
  }
}
