import 'package:dartz/dartz.dart';
import 'package:postsapp/core/error/exceptions.dart';
import 'package:postsapp/core/error/failures.dart';
import 'package:postsapp/core/network/network_info.dart';
import 'package:postsapp/features/posts/data/datasources/post_local_data_source.dart';
import 'package:postsapp/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:postsapp/features/posts/data/models/post_model.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/domain/repository/post_repository.dart';
typedef Future<Unit> DeleteOrUpdateOrAddPost();
class PostsRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async{
    final PostModel postModel = PostModel(
      title: post.title,
      body: post.body,
    );
    return await _getMessage((){
      return remoteDataSource.addPost(postModel);
    });

  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async{
    return await _getMessage((){
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async{
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
  return await _getMessage((){
    return remoteDataSource.updatePost(postModel);
  });


  }
  Future<Either<Failure, Unit>>  _getMessage(DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost)async{
    if(await networkInfo.isConnected){
      try{
        await deleteOrUpdateOrAddPost();
        return Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }
}
