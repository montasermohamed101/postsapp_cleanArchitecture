import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/core/app_theme.dart';
import 'package:postsapp/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())) ,
          BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostsBloc>()) ,
        ],
        child: MaterialApp(
      theme: appTheme,
          debugShowCheckedModeBanner: false,
          home:  PostsPage(),
    )
    );
  }
}

