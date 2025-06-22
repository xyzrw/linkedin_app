import 'package:linkedin_app/models/profile.dart';
import 'package:linkedin_app/utils/data.dart';

class ProfileService {
  //Fetching current user's profile data
  Profile fetchProfile(String email) {
    Data.authUserData.addAll({'email': email});
    return Profile.fromJson(Data.authUserData);
  }
}
