import 'package:flutter/material.dart';
import 'package:linkedin_app/utils/consts.dart';
import 'package:linkedin_app/viewmodels/post_viewmodel.dart';
import 'package:linkedin_app/viewmodels/profile_viewmodel.dart';
import 'package:linkedin_app/views/widgets/post_widget.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Post and Profile View models
    final postViewModel = Provider.of<PostViewmodel>(context);
    final profileViewModel = Provider.of<ProfileViewmodel>(context);

    // Screen height and width
    double height(double hight) => MediaQuery.of(context).size.height * hight;
    double width(double width) => MediaQuery.of(context).size.width * width;

    //Open to, Add section buttons
    Widget flexButton(String text, bool invert) => Flexible(
      flex: 5,
      child: SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              invert ? Colors.white : primaryColor,
            ),
            foregroundColor: WidgetStatePropertyAll(
              invert ? primaryColor : Colors.white,
            ),
            elevation: WidgetStatePropertyAll(0.4),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: invert ? primaryColor : Colors.transparent,
                  width: 1,
                  strokeAlign: 1,
                ),
              ),
            ),
          ),
          child: Text(text),
        ),
      ),
    );

    //Custom card for sections
    Widget customCard(
      List<Widget> widget, {
      String? title,
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? titlePadding,
    }) {
      return Card(
        color: Colors.white,
        elevation: 0.1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Padding(
                  padding: titlePadding ?? EdgeInsets.zero,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {},
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                ),
              Column(children: widget),
            ],
          ),
        ),
      );
    }

    // Analytics section list tile
    Widget customListTile(String title, String subtitle, IconData icn) {
      return Column(
        children: [
          ListTile(
            leading: Icon(icn),
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(subtitle),
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.zero,
          ),
          Divider(color: Colors.grey.shade300, thickness: 1.2),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Flexible(
              flex: 6,
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  autofocus: false,
                  initialValue: profileViewModel.userProfile!.user.name,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    filled: true,
                    fillColor: Color.fromRGBO(0, 119, 181, 0.1),
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.grey.shade600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Details section
            customCard([
              SizedBox(
                height: height(0.22),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Flexible(
                          flex: 6,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Image.asset(
                              profileViewModel.userProfile!.coverImagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                top: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: () {},
                                    child: Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: width(0.05),
                      child: CircleAvatar(
                        radius: width(0.16),
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            profileViewModel.userProfile!.user.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileViewModel.userProfile!.user.name,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height(0.005)),
                    SizedBox(
                      child: Text(
                        profileViewModel.userProfile!.user.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                    SizedBox(height: height(0.008)),
                    SizedBox(
                      child: Text(
                        '${profileViewModel.userProfile!.company}  ·  ${profileViewModel.userProfile!.education}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        profileViewModel.userProfile!.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    SizedBox(height: height(0.01)),
                    SizedBox(
                      child: Text(
                        '200 connections',
                        style: TextStyle(
                          fontSize: 15,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: height(0.012)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        flexButton('Open to', false),
                        Flexible(flex: 1, child: SizedBox()),
                        flexButton('Open to', true),
                        Flexible(
                          flex: 2,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: IconButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.white,
                                ),
                                foregroundColor: WidgetStatePropertyAll(
                                  Colors.grey.shade600,
                                ),
                                shape: WidgetStatePropertyAll(
                                  CircleBorder(
                                    side: BorderSide(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ),
                              icon: Icon(Icons.more_horiz),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height(0.01)),
                  ],
                ),
              ),
            ], padding: EdgeInsets.zero),
            SizedBox(height: height(0.01)),

            // Analytics section
            customCard([
              Row(
                children: [
                  Icon(Icons.visibility, color: Colors.grey, size: 20),
                  SizedBox(width: 5),
                  Text(
                    'Private to you',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: height(0.01)),
              customListTile(
                '100 profile views',
                'Discover who\'s viewed your profile.',
                Icons.people,
              ),
              customListTile(
                '200 post impressions',
                'Check out who\'s engaging with your posts.',
                Icons.bar_chart,
              ),
              customListTile(
                '80 search appearances',
                'See how often you appear in search results.',
                Icons.search,
              ),
              SizedBox(height: height(0.01)),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show all analytics',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward, color: Colors.grey.shade700),
                  ],
                ),
              ),
              SizedBox(height: height(0.01)),
            ], title: 'Analytics'),
            SizedBox(height: height(0.01)),

            // About section
            customCard([
              Padding(
                padding: EdgeInsets.symmetric(vertical: height(0.01)),
                child: SizedBox(
                  child: Text(profileViewModel.userProfile!.about),
                ),
              ),
            ], title: 'About'),
            SizedBox(height: height(0.01)),

            // Activity section
            customCard(
              [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          '200 followers',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height(0.01)),
                //Posted by current user
                PostWidget(
                  post: profileViewModel.getUserPosts().first,
                  postViewModel: postViewModel,
                ),
                SizedBox(height: height(0.005)),
                Divider(indent: 20, endIndent: 20),
                SizedBox(height: height(0.018)),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show all analytics',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward, color: Colors.grey.shade700),
                    ],
                  ),
                ),
                SizedBox(height: height(0.02)),
              ],
              title: 'Activity',
              padding: EdgeInsets.zero,
              titlePadding: EdgeInsets.only(left: 20, right: 20, top: 8),
            ),
            SizedBox(height: height(0.01)),

            // Experiance section
            customCard(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: width(0.05),
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo2.png',

                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          'AI Researcher',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Google'),
                            Text(
                              'Jan 2020 - Present  ·  5 yrs 6 mon ',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13.5,
                              ),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height(0.005)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(flex: 1, child: Icon(Icons.diamond)),
                    Flexible(
                      flex: 9,
                      child: Text(
                        'Machine Learning, Deep Learning, Natural Language Processing',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height(0.01)),
              ],
              title: 'Experiance',
              titlePadding: EdgeInsets.only(top: 5),
            ),
            SizedBox(height: height(0.01)),

            // Education section
            customCard(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: width(0.05),
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/university.jpg',

                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          profileViewModel.userProfile!.education,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Msc in Computer Science'),
                            Text(
                              '2015 - 2020',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13.5,
                              ),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height(0.005)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(flex: 1, child: Icon(Icons.diamond)),
                    Flexible(
                      flex: 9,
                      child: Text(
                        'Artificial Intelligence, Algorithms, Data Structures, Machine Learning, Computer Vision',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height(0.01)),
              ],
              title: 'Education',
              titlePadding: EdgeInsets.only(top: 5),
            ),
            SizedBox(height: height(0.05)),
          ],
        ),
      ),
    );
  }
}
