import 'package:flutter/material.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/pages/post_detail_page.dart';

class PostListWidget extends StatelessWidget {
  List<Post> posts;

  PostListWidget({required this.posts, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].body,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => PostDetailPage(post: posts[index])));
            },
          );
        },
        separatorBuilder: (context, index) => Divider(

          thickness: 1,
            ),
        itemCount: posts.length);
  }
}
