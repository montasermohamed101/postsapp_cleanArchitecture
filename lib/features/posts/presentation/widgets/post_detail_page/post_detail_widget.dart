import 'package:flutter/material.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_detail_page/delete_post_btn_widget.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_detail_page/update_post_btn_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  PostDetailWidget({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post:post),
              DeletePostBtnWidget(postId:post.id!),
            ],
          ),
        ],
      ),
    );
  }
}
