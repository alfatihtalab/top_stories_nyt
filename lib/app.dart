import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_stories_nyt/bloc/news_cubit/news_cubit.dart';
import 'package:top_stories_nyt/data/repository/top_stories_repository.dart';
import 'package:top_stories_nyt/ui/controller_page_/app_state_controller_page_.dart';
import 'package:top_stories_nyt/ui/helper_page_/error_connection_page.dart';

import 'bloc/internet_cubit/internet_cubit.dart';

class AppProvider extends StatelessWidget {
  AppProvider({super.key, required this.topStoriesRepository});
  final TopStoriesRepository topStoriesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<InternetCubit>(
        create: (_) => InternetCubit(connectivity: Connectivity()),
      ),

      BlocProvider<NewsCubit>(
        create: (_) => NewsCubit(topStoriesRepository),
      ),
    ],

        child: MaterialApp.router(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Top Stories NY',
    ));
  }

  // routes of the page using new lib go_router
  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const AppStateControllerPage();
        },
      ),
      GoRoute(
        path: '/errorPage',
        builder: (BuildContext context, GoRouterState state) {
          return const ErrorConnectionPage();
        },
      ),
    ],
  );

}