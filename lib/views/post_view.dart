import 'package:flutter/material.dart';
import 'package:linkedin_app/models/post.dart';
import 'package:linkedin_app/utils/consts.dart';
import 'package:linkedin_app/viewmodels/post_viewmodel.dart';
import 'package:linkedin_app/viewmodels/profile_viewmodel.dart';
import 'package:linkedin_app/views/widgets/post_widget.dart';
import 'package:provider/provider.dart' show Provider;

class PostView extends StatefulWidget {
  final Post post;
  const PostView({super.key, required this.post});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  // Screen height and width
  double height(double hight) => MediaQuery.of(context).size.height * hight;
  double width(double width) => MediaQuery.of(context).size.width * width;

  final _commentController = TextEditingController(text: '');

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Post and Profile View models
    final postViewModel = Provider.of<PostViewmodel>(context);
    final profileViewModel = Provider.of<ProfileViewmodel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Column(
        children: [
          // Show comments of the post
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PostWidget(post: widget.post, postViewModel: postViewModel),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.post.comments.length,
                    itemBuilder: (context, index) {
                      final comment = widget.post.comments[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.asset(
                                  comment.user.imagePath,
                                  height: 45,
                                  width: 45,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              comment.user.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.user.description,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  comment.text,
                                  style: TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height(0.008)),
          // Add comments to post
          Column(
            children: [
              Divider(
                color: Colors.grey.shade300,
                endIndent: width(0.08),
                indent: width(0.08),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
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
                      Flexible(
                        flex: 8,
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: _commentController,
                            autofocus: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(0, 119, 181, 0.1),
                              hintText: 'Comment',
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
                      Flexible(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {
                            postViewModel.addComment(
                              widget.post,
                              _commentController.text,
                              profileViewModel.userProfile!.user,
                            );
                            _commentController.clear();
                            FocusScope.of(context).unfocus();
                          },
                          icon: Icon(Icons.send),
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height(0.008)),
        ],
      ),
    );
  }
}
