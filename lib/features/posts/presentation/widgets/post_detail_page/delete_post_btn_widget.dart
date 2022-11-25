import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/core/util/snackbar_message.dart';
import 'package:postsapp/core/widgets/loading_widget.dart';
import 'package:postsapp/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/pages/posts_page.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_detail_page/delete_dialog_widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;

  const DeletePostBtnWidget({
    required this.postId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
        ),
        onPressed: ()=> deleteDialog(context, postId),
        icon: Icon(Icons.delete_outline),
        label: Text("Delete"));
  }
  void deleteDialog(BuildContext context,int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return  BlocConsumer<AddDeleteUpdatePostsBloc, AddDeleteUpdatePostsState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => PostsPage(),
                    ),
                        (route) => false);
              }else if(state is ErrorAddDeleteUpdatePostState){
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if(state is LoadingAddDeleteUpdatePostState){
                return AlertDialog(
                  title: LoadingWidget(),
                );
              }else{
                return DeleteDialogWidget(postId:postId);
              }
            },
          );
        });
  }
}
