import 'package:flutter/material.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/pages/post_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;

  UpdatePostBtnWidget({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostAddUpdatePage(
                  isUpdatePost: true,
                  post: post,
                ),
              ));
        },
        icon: Icon(Icons.edit),
        label: Text("Edit"));
  }
}
