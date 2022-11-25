import 'package:dartz/dartz.dart';
import 'package:postsapp/core/error/failures.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/domain/repository/post_repository.dart';

class GetAllPostsPostUseCase{
  final PostRepository repository;

  GetAllPostsPostUseCase(this.repository);

  Future<Either<Failure,List<Post>>> call()async{
    return await repository.getAllPosts();
  }

}