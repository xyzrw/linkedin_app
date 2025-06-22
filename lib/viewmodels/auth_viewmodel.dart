import 'package:flutter/foundation.dart';
import 'package:linkedin_app/services/auth_service.dart';
import 'package:linkedin_app/viewmodels/profile_viewmodel.dart';

class AuthViewmodel extends ChangeNotifier {
  final _authService = AuthService();

  void _fetchUserProfile(String email) {
    ProfileViewmodel().fetchUserData(email);
    notifyListeners();
  }

  bool authUser(bool isSignin, String email, String password) {
    bool status =
        isSignin
            ? _authService.signIn(email, password)
            : _authService.signUp(email, password);
    //Fetching user's profile after authenticated
    _fetchUserProfile(email);
    return status;
  }
}
