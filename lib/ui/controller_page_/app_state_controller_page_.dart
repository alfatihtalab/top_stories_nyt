import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_stories_nyt/ui/helper_page_/error_connection_page.dart';
import '../../bloc/internet_cubit/internet_cubit.dart';
import '../top_stories_page.dart';



class AppStateControllerPage extends StatefulWidget {
  const AppStateControllerPage({super.key});

  @override
  State<AppStateControllerPage> createState() => _AppStateControllerPageState();
}

class _AppStateControllerPageState extends State<AppStateControllerPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        // print(state);
        if (state is InternetConnected) {
          return const TopStoriesListPage();
        }
        else if (state is InternetDisconnected) {
          return const ErrorConnectionPage();
        }
        return const Center(child: CircularProgressIndicator(),);
      },
    ));
  }
}
