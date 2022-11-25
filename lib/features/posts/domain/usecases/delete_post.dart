import 'package:dartz/dartz.dart';
import 'package:postsapp/core/error/failures.dart';
import 'package:postsapp/features/posts/domain/repository/post_repository.dart';

class DeletePostUsecase{
  final PostRepository repository;

  DeletePostUsecase(this.repository);

  Future<Either<Failure,Unit>> call(int postId) async{
    return await repository.deletePost(postId);
  }
}