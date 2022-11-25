import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:postsapp/core/network/network_info.dart';
import 'package:postsapp/features/posts/data/datasources/post_local_data_source.dart';
import 'package:postsapp/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:postsapp/features/posts/data/repositories/post_repository_impl.dart';
import 'package:postsapp/features/posts/domain/repository/post_repository.dart';
import 'package:postsapp/features/posts/domain/usecases/add_post.dart';
import 'package:postsapp/features/posts/domain/usecases/delete_post.dart';
import 'package:postsapp/features/posts/domain/usecases/get_all_posts.dart';
import 'package:postsapp/features/posts/domain/usecases/update_post.dart';
import 'package:postsapp/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init()async{
  // Features = posts

  // Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostsBloc(
    addPost:sl() ,
    updatePost:sl() ,
    deletePost:sl() ,
  ));


  // UseCases
  sl.registerLazySingleton(() => GetAllPostsPostUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(() => PostsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo:sl(),)
  );
  // DataSources

  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocaleDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}