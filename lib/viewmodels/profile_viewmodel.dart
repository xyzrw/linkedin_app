import 'package:flutter/foundation.dart';
import 'package:linkedin_app/models/post.dart';
import 'package:linkedin_app/models/profile.dart';
import 'package:linkedin_app/services/profile_service.dart';
import 'package:linkedin_app/viewmodels/post_viewmodel.dart';

class ProfileViewmodel extends ChangeNotifier {
  // Singleton instance
  static final ProfileViewmodel _instance = ProfileViewmodel._internal();
  factory ProfileViewmodel() => _instance;
  ProfileViewmodel._internal();

  final _profileService = ProfileService();

  // Profile getter
  Profile? _userProfile;
  Profile? get userProfile => _userProfile;

  // Fetching user profile from service
  void fetchUserData(String email) {
    _userProfile = _profileService.fetchProfile(email);
    notifyListeners();
  }

  // Taking posts belonging to the current user
  List<Post> getUserPosts() {
    return PostViewmodel().posts
        .where((post) => post.user.uid == _userProfile!.user.uid)
        .toList();
  }
}
