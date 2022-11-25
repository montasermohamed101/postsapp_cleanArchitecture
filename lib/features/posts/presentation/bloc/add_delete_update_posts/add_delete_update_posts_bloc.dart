import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:postsapp/core/error/failures.dart';
import 'package:postsapp/core/strings/failures.dart';
import 'package:postsapp/core/strings/messages.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/domain/usecases/add_post.dart';
import 'package:postsapp/features/posts/domain/usecases/delete_post.dart';
import 'package:postsapp/features/posts/domain/usecases/update_post.dart';

part 'add_delete_update_posts_event.dart';
part 'add_delete_update_posts_state.dart';

class AddDeleteUpdatePostsBloc
    extends Bloc<AddDeleteUpdatePostsEvent, AddDeleteUpdatePostsState> {
  final AddPostUsecase addPost;
  final UpdatePostUsecase updatePost;
  final DeletePostUsecase deletePost;
  AddDeleteUpdatePostsBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
}) : super(AddDeleteUpdatePostsInitial()) {
    on<AddDeleteUpdatePostsEvent>((event, emit)async {
      if(event is AddPostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage,ADD_SUCCESS_MESSAGE));
      }else if(event is UpdatePostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage,UPDATE_SUCCESS_MESSAGE));
      }else if(event is DeletePostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePost(event.postId);
            emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage,DELETE_SUCCESS_MESSAGE));

      }else{

      }

    });
  }
  AddDeleteUpdatePostsState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
          (failure) => ErrorAddDeleteUpdatePostState(
        message: _mapFailureToMessage(failure),
      ),
          (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }
  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:  return "Unexpected Error , Please try again later .";
    }
  }
}


