import 'package:flutter/material.dart';
import 'package:users_app/core/constants/routes/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/routes/routes_name.dart';
import 'core/constants/theme.dart';
import 'core/init/locator.dart';
import 'cubit/search_active/search_active_cubit.dart';
import 'cubit/user/user_list/user_list_cubit.dart';
import 'helper/navigation/navigation_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserListCubit(),
        ),
        BlocProvider(
          create: (context) => SearchActiveCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'User App',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationHelper.navigatorKey,
        theme: getIt<AppTheme>().userAppTheme,
        routes: appRoutes,
        initialRoute: AppRoutesNames.userListView,
      ),
    );
  }
}
