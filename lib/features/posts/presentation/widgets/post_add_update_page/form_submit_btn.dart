import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;
  FormSubmitBtn({
    required this.onPressed,
    required this.isUpdatePost,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: isUpdatePost ? Icon(Icons.edit) : Icon(Icons.add),
        label: Text(isUpdatePost ? "Update" : "Add"));
  }
}
