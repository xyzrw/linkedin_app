import 'package:flutter/foundation.dart';
import 'package:linkedin_app/models/comment.dart';
import 'package:linkedin_app/models/post.dart';
import 'package:linkedin_app/models/user.dart';
import 'package:linkedin_app/services/post_service.dart';

class PostViewmodel extends ChangeNotifier {
  // Singleton instance
  static final PostViewmodel _instance = PostViewmodel._internal();
  factory PostViewmodel() => _instance;
  PostViewmodel._internal();

  final PostService _postService = PostService();
  List<Post> _posts = [];
  bool _loading = false;

  // Getters for posts and loading state
  List<Post> get posts => _posts;
  bool get loading => _loading;

  // Fetch posts from the service
  Future<void> fetchPosts() async {
    _loading = true;
    notifyListeners();
    _posts = await _postService.fetchPosts();
    _loading = false;
    notifyListeners();
  }

  // Like or unlike a post
  void likePost(Post post) {
    var index = _posts.indexWhere((p) => p == post);
    if (index != -1) {
      var selectedPost = _posts[index];
      if (!selectedPost.liked) {
        selectedPost.liked = true;
        selectedPost.likes++;
      } else {
        selectedPost.liked = false;
        if (selectedPost.likes > 0) {
          selectedPost.likes--;
        }
      }
      notifyListeners();
    }
  }

  //Add comment to a post
  void addComment(Post post, String text, User user) {
    if (text.isNotEmpty) {
      post.addComment(
        Comment(text: text, user: user, postedDate: DateTime.now()),
      );
      notifyListeners();
    }
  }
}
