part of 'add_delete_update_posts_bloc.dart';

@immutable
abstract class AddDeleteUpdatePostsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AddDeleteUpdatePostsInitial extends AddDeleteUpdatePostsState {

}


class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostsState{

}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostsState{
  final String message;

  ErrorAddDeleteUpdatePostState({required this.message});
  @override
  List<Object?> get props => [message];
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostsState{
  final String message;

  MessageAddDeleteUpdatePostState({required this.message});
  @override
  List<Object?> get props => [message];
}