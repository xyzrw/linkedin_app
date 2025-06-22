import 'package:linkedin_app/models/user.dart';

class Profile {
  final String email;
  final String coverImagePath;
  final String company;
  final String education;
  final String location;
  final String about;
  final User user;

  Profile({
    required this.email,
    required this.coverImagePath,
    required this.company,
    required this.education,
    required this.location,
    required this.about,
    required this.user,
  });
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      company: json['company'] as String,
      education: json['education'] as String,
      about: json['about'] as String,
      location: json['location'] as String,
      email: json['email'] as String,
      coverImagePath: json['coverImagePath'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
