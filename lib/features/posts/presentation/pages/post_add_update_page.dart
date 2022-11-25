import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/core/util/snackbar_message.dart';
import 'package:postsapp/core/widgets/loading_widget.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/pages/posts_page.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  PostAddUpdatePage({
    this.post,
    required this.isUpdatePost,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post"),);
  }

  Widget _buildBody() {
    return Center(child: Padding(padding: EdgeInsets.all(10),
      child: BlocConsumer<AddDeleteUpdatePostsBloc, AddDeleteUpdatePostsState>(
        listener: (context, state) {
          if (state is MessageAddDeleteUpdatePostState) {
            SnackBarMessage().showSuccessSnackBar(message: state.message,
                context: context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_)=> PostsPage()), (route) => false);
          }else if(state is ErrorAddDeleteUpdatePostState){
            SnackBarMessage().showErrorSnackBar(message: state.message,
                context: context);
          }
        },
        builder: (context, state) {
          if (state is LoadingAddDeleteUpdatePostState) {
            return LoadingWidget();
          } else {
            return FormWidget(
                isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
          }
        },

      )
      ,),);
  }
}
