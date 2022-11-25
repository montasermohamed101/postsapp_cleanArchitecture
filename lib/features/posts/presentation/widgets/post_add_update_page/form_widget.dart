import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_add_update_page/form_submit_btn.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_add_update_page/text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  FormWidget({
     this.post,
    required this.isUpdatePost,
    Key? key,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  @override
  void initState() {
   if(widget.isUpdatePost){
     _titleController.text = widget.post!.title;
     _bodyController.text = widget.post!.body;
   }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key:_formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
              name:'Title',
              multiLines:false,
              controller:_titleController,
            ),
            TextFormFieldWidget(
              name:'Body',
              multiLines:true,
              controller:_bodyController,
            ),
            FormSubmitBtn(
              isUpdatePost:widget.isUpdatePost,
              onPressed:validateFormThenUpdateOrAddPost,
            ),
          ],
        ),

      ),
    );
  }
  void validateFormThenUpdateOrAddPost(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      final post = Post(id: widget.isUpdatePost? widget.post!.id :null,
          title: _titleController.text,
          body: _bodyController.text);
      if(widget.isUpdatePost){
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context).add(UpdatePostEvent(post: post));
      }else{
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context).add(AddPostEvent(post: post));
      }
    }
  }
}
