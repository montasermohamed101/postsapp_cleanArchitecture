import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/core/widgets/loading_widget.dart';
import 'package:postsapp/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:postsapp/features/posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:postsapp/features/posts/presentation/widgets/posts_page/post_list_widget.dart';

class PostsPage extends StatelessWidget {
   PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body:_buildBody(),
    floatingActionButton:   _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: Text('Posts'),);

  Widget _buildBody() {
    return Padding(padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc,PostsState>(
        builder: (context,state){
          if(state is LoadingPostsState){
            return LoadingWidget();
          }else if(state is LoadedPostsState){
            return RefreshIndicator(
              onRefresh: ()=>_onRefresh(context),
              child: PostListWidget(
                posts:state.posts
              ),
            );
          }else if(state is ErrorPostsState){
            return MessageDisplayWidget(
              message:state.message
            );
          }
          return LoadingWidget();
        },
      ),
    );
  }


  Future<void> _onRefresh(BuildContext context)async{
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());

   }
 Widget  _buildFloatingBtn(context){
    return FloatingActionButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>
          PostAddUpdatePage(isUpdatePost: false)));
    },
    child: Icon(Icons.add),
    );
  }
}
