import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demoecommerce/BusinessLogic/HomeListing/cubit/homelisting_cubit.dart';
import 'package:demoecommerce/BusinessLogic/category/cubit/category_cubit.dart';
import 'package:demoecommerce/BusinessLogic/connectioncheck/cubit/connectioncheck_cubit.dart';
import 'package:demoecommerce/BusinessLogic/profile/cubit/profile_cubit.dart';
import 'package:demoecommerce/BusinessLogic/theme/cubit/theme_cubit.dart';
import 'package:demoecommerce/constants.dart';
import 'package:demoecommerce/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (await Permission.storage.status == PermissionStatus.granted) {
    var appdir = await getApplicationDocumentsDirectory();
    Hive..init(appdir.path);
    await Hive.openBox('settings');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AutoRouter route = AutoRouter();
  Connectivity connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => ProfileCubit())),
        BlocProvider(create: ((context) => ThemeCubit()), lazy: true),
        BlocProvider(
            create: (context) =>
                ConnectioncheckCubit(connectivity: connectivity)),
        BlocProvider(create: (context) => CategoryCubit(), lazy: true),
        BlocProvider(create: (context) => HomelistingCubit(), lazy: true),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme_state) {
          return MaterialApp(
            title: 'Fyn Now Seller',
            debugShowCheckedModeBanner: false,
            theme: theme_state is ThemeLoaded ? theme_state.theme : lightTheme,
            onGenerateRoute: route.onGeneratedRoute,
          );
        },
      ),
    );
  }
}
