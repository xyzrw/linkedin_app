import 'package:flutter/material.dart';
import 'package:linkedin_app/viewmodels/post_viewmodel.dart';
import 'package:linkedin_app/viewmodels/profile_viewmodel.dart';
import 'package:linkedin_app/views/post_view.dart';
import 'package:linkedin_app/views/profile_view.dart';
import 'package:linkedin_app/views/widgets/post_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch posts after context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<PostViewmodel>(context, listen: false).fetchPosts();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Model Views
    final postViewModel = Provider.of<PostViewmodel>(context);
    final profileViewModel = Provider.of<ProfileViewmodel>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(247, 250, 252, 1),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          // Bottom Navigation Bar
          child: BottomNavigationBar(
            selectedItemColor: Colors.grey.shade900,
            elevation: 1,
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            currentIndex: _navIndex,
            onTap: (value) {
              setState(() => _navIndex = value);
            },
            selectedIconTheme: IconThemeData(color: Colors.grey.shade900),
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.post_add),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_rounded),
                label: 'My Network',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      // Tap profile image to go to the profile page
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileView(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.asset(
                              profileViewModel.userProfile!.user.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            autofocus: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(0, 119, 181, 0.1),
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Colors.grey.shade600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            // Show loading while posts are getting fetched
            postViewModel.loading
                ? Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 80,
                      width: 80,

                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        strokeWidth: 6,
                      ),
                    ),
                  ),
                )
                //Posts list
                : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: postViewModel.posts.length,
                    itemBuilder: (context, index) {
                      var post = postViewModel.posts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PostView(post: post),
                              ),
                            );
                          },
                          child: Card(
                            child: PostWidget(
                              post: post,
                              postViewModel: postViewModel,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
