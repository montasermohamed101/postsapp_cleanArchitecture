import 'package:flutter/material.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_detail_page/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  PostDetailPage({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }
  AppBar _buildAppbar(){
    return AppBar(title: Text("Post Detail"),);
  }

  Widget _buildBody(){
    return Center(child: Padding(
      padding: const EdgeInsets.all(10),
      child: PostDetailWidget(post:post),
    ),);
  }
}
