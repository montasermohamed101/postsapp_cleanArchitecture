import 'package:dartz/dartz.dart';
import 'package:postsapp/core/error/failures.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/domain/repository/post_repository.dart';


class AddPostUsecase{
  final PostRepository repository;

  AddPostUsecase(this.repository);

  Future<Either<Failure,Unit>> call(Post post)async{
    return await repository.addPost(post);
  }

}