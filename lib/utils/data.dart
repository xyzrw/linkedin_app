import 'package:linkedin_app/models/comment.dart';
import 'package:linkedin_app/models/post.dart';
import 'package:linkedin_app/models/user.dart';

class Data {
  //Current user profile data
  static Map<String, dynamic> authUserData = {
    'coverImagePath': 'assets/posts/5.jpg',
    'company': 'Google',
    'education': 'University of Washington',
    'location': 'Metropolis, Illinois',
    'about':
        'AI Researcher at Google. Passionate about advancing machine learning and artificial intelligence. Skilled in deep learning, natural language processing, and computer vision. Regular speaker at international tech conferences and contributor to open-source AI projects. Always exploring new technologies and striving to make a positive impact through AI-driven solutions.',
    'user': {
      'uid': '12345678',
      'name': 'Clark Kent',
      'description':
          'AI Researcher | Leading AI innovation | Passionate about machine learning',
      'imagePath': 'assets/avatars/avatar.jpg',
    },
  };

  //Users list
  static Map<String, User> users = {
    'Grace': User(
      'Grace Hopper',
      'AI Researcher | Pixel Enthusiast',
      'assets/avatars/2.png',
      _randomUid(),
    ),
    'Alice': User(
      'Alice Smith',
      'Mobile Developer | Google Enthusiast',
      'assets/avatars/6.jpg',
      _randomUid(),
    ),
    'John': User(
      'John Doe',
      'BSc Software Engineering | Freelancer |AI/ML | Flutter',
      'assets/avatars/3.jpg',
      _randomUid(),
    ),
    'Bruce': User(
      'Bruce Wayne',
      'Crypto Trader | Blockchain Advocate',
      'assets/avatars/1.jpg',
      _randomUid(),
    ),
    'Clara': User(
      'Clara Oswald',
      'Backend Engineer | Server Specialist',
      'assets/avatars/4.jpg',
      _randomUid(),
    ),
    'David': User(
      'David West',
      'Digital Marketer | Social Media Analyst',
      'assets/avatars/5.jpg',
      _randomUid(),
    ),
    'Emily': User(
      'Emily Doe',
      'Recent Graduate | Aspiring Software Engineer',
      'assets/avatars/8.jpg',
      _randomUid(),
    ),
    'Frank': User(
      'Frank Miller',
      'Android Developer | Tech Blogger',
      'assets/avatars/7.jpg',
      _randomUid(),
    ),
    'Clark': User.fromJson(authUserData['user']),
  };

  //Random list of characters for user id
  static String _randomUid({int length = 16}) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(
      length,
      (index) =>
          chars[(DateTime.now().microsecondsSinceEpoch + index) % chars.length],
    ).join();
  }

  //Random posts from different users
  static List<Post> posts = [
    Post(
      description:
          "Pixel AI is changing the way we interact with our devices. The on-device intelligence and real-time suggestions are super helpful. Excited for what's next!",
      createdDate: DateTime.now().subtract(Duration(days: 17)),
      imagePath: 'assets/posts/1.jpg',
      likes: 2437,
      user: users['Grace']!,
      comments: comments.sublist(2, 7),
    ),
    Post(
      description:
          "Google I/O 2024 was incredible! The new AI-powered features in Android and the advancements in Flutter blew my mind. Can't wait to try out the new APIs and share my experiments.",
      createdDate: DateTime.now().subtract(Duration(days: 400)),
      imagePath: 'assets/posts/3.jpg',
      likes: 3200,
      user: users['Alice']!,
      comments: comments.sublist(0, 4),
    ),
    Post(
      description:
          "Excited to share that I have successfully completed my latest project using Flutter! 🚀 It was a challenging journey, but I learned a lot about state management, UI design, and integrating APIs. Looking forward to building more amazing apps!",
      createdDate: DateTime.now(),
      imagePath: 'assets/posts/5.jpg',
      likes: 4000,
      user: users['John']!,
      comments: comments.sublist(5, 11),
    ),
    Post(
      description:
          "Crypto trading has been a rollercoaster lately! 📈📉 Learned a lot about risk management and the importance of staying updated with market trends. Always do your own research!",
      createdDate: DateTime.now().subtract(Duration(days: 2)),
      imagePath: 'assets/posts/4.jpg',
      likes: 2100,
      user: users['Bruce']!,
      comments: comments.sublist(8, 13),
    ),
    Post(
      description:
          "Just finished setting up a new server for my side project. The performance boost is amazing! If you need tips on server optimization, feel free to ask.",
      createdDate: DateTime.now().subtract(Duration(days: 3)),
      imagePath: 'assets/posts/6.jpg',
      likes: 1500,
      user: users['Clara']!,
      comments: comments.sublist(10, 15),
    ),
    Post(
      description:
          "Graduated from university today! 🎓 Four years of hard work, late nights, and amazing friendships. Ready to take on new challenges in the tech industry.",
      createdDate: DateTime.now().subtract(Duration(days: 5)),
      imagePath: 'assets/posts/7.jpg',
      likes: 2700,
      user: users['Emily']!,
      comments: comments.sublist(12, 18),
    ),
    Post(
      description:
          "Exploring the latest Android 15 features. The new privacy controls and UI enhancements are fantastic. Android development just keeps getting better!",
      createdDate: DateTime.now().subtract(Duration(days: 20)),
      imagePath: 'assets/posts/2.jpg',
      likes: 2300,
      user: users['Frank']!,
      comments: comments.sublist(6, 10),
    ),
    Post(
      description:
          "Exploring Google Cloud Platform has been an eye-opening experience! The scalability, security, and AI integrations make it a top choice for modern applications. Highly recommend checking out GCP for your next project.",
      createdDate: DateTime.now().subtract(Duration(days: 7)),
      imagePath: 'assets/posts/8.jpg',
      likes: 1850,
      user: users['Clark']!,
      comments: comments.sublist(3, 8),
    ),
  ];

  //Random comments from different users
  static List<Comment> comments = [
    Comment(
      text: "Amazing achievement, congratulations!",
      postedDate: DateTime.now().subtract(Duration(days: 1, hours: 2)),
      user: users['Alice']!,
    ),
    Comment(
      text: "Thanks for sharing your experience. Very insightful.",
      postedDate: DateTime.now().subtract(Duration(days: 2, hours: 5)),
      user: users['John']!,
    ),
    Comment(
      text: "This is really inspiring. Keep it up!",
      postedDate: DateTime.now().subtract(Duration(days: 3, hours: 1)),
      user: users['Emily']!,
    ),
    Comment(
      text: "Great work! Looking forward to your next project.",
      postedDate: DateTime.now().subtract(Duration(days: 4, hours: 3)),
      user: users['Frank']!,
    ),
    Comment(
      text: "Congratulations on your graduation!",
      postedDate: DateTime.now().subtract(Duration(days: 5, hours: 2)),
      user: users['Grace']!,
    ),
    Comment(
      text: "The new features sound awesome. Thanks for the update.",
      postedDate: DateTime.now().subtract(Duration(days: 6, hours: 4)),
      user: users['David']!,
    ),
    Comment(
      text: "Well done! Your dedication is admirable.",
      postedDate: DateTime.now().subtract(Duration(days: 7, hours: 2)),
      user: users['Clara']!,
    ),
    Comment(
      text: "I totally agree with your thoughts on AI.",
      postedDate: DateTime.now().subtract(Duration(days: 8, hours: 1)),
      user: users['Bruce']!,
    ),
    Comment(
      text: "Impressive! Thanks for motivating us.",
      postedDate: DateTime.now().subtract(Duration(days: 9, hours: 3)),
      user: users['Alice']!,
    ),
    Comment(
      text: "Can you share more about your server setup?",
      postedDate: DateTime.now().subtract(Duration(days: 10, hours: 2)),
      user: users['John']!,
    ),
    Comment(
      text: "Excited to see what you build next!",
      postedDate: DateTime.now().subtract(Duration(days: 11, hours: 4)),
      user: users['Emily']!,
    ),
    Comment(
      text: "This is a game changer for mobile devs.",
      postedDate: DateTime.now().subtract(Duration(days: 12, hours: 1)),
      user: users['Frank']!,
    ),
    Comment(
      text: "Your journey is truly inspiring.",
      postedDate: DateTime.now().subtract(Duration(days: 13, hours: 2)),
      user: users['Grace']!,
    ),
    Comment(
      text: "Thanks for the tips on optimization!",
      postedDate: DateTime.now().subtract(Duration(days: 14, hours: 3)),
      user: users['David']!,
    ),
    Comment(
      text: "AI is definitely the future. Great post.",
      postedDate: DateTime.now().subtract(Duration(days: 15, hours: 2)),
      user: users['Clara']!,
    ),
    Comment(
      text: "Congrats! Wishing you all the best.",
      postedDate: DateTime.now().subtract(Duration(days: 16, hours: 1)),
      user: users['Bruce']!,
    ),
    Comment(
      text: "Very helpful insights, thank you.",
      postedDate: DateTime.now().subtract(Duration(days: 17, hours: 4)),
      user: users['Alice']!,
    ),
    Comment(
      text: "Looking forward to more updates from you.",
      user: users['John']!,
      postedDate: DateTime.now().subtract(Duration(days: 18, hours: 2)),
    ),
    Comment(
      text: "This is so cool! Thanks for sharing.",
      postedDate: DateTime.now().subtract(Duration(days: 19, hours: 3)),
      user: users['Emily']!,
    ),
    Comment(
      text: "Great advice on risk management.",
      postedDate: DateTime.now().subtract(Duration(days: 20, hours: 1)),
      user: users['Frank']!,
    ),
  ];
}
