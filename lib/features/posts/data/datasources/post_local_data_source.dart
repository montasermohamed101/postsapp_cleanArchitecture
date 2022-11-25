import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:postsapp/core/error/exceptions.dart';
import 'package:postsapp/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:postsapp/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource{
  Future<List<PostModel>> getCachedPosts();
 Future<Unit> cachePosts(List<PostModel> postModels);
}
const CACHED_POSTS = "CACHED_POSTS";
class PostLocaleDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;

  PostLocaleDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelToJson = postModels
        .map<Map<String,dynamic>>((postModels) => postModels.toJson()).toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if(jsonString != null){
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    }else{
      throw EmptyCacheException;
    }
  }

}