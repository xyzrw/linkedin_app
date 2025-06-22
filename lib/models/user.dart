class User {
  final String uid;
  final String name;
  final String description;
  final String imagePath;

  User(this.name, this.description, this.imagePath, this.uid);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['name'] as String,
      json['description'] as String,
      json['imagePath'] as String,
      json['uid'] as String,
    );
  }
}
