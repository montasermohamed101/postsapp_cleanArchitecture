import 'package:postsapp/core/error/failures.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure,List<Post>>> getAllPosts();


  Future<Either<Failure,Unit>> deletePost(int id);
  Future<Either<Failure,Unit>>  updatePost(Post post);
  Future<Either<Failure,Unit>>  addPost(Post post);

}
