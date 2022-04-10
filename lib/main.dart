import 'package:demoecommerce/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AutoRouter route = AutoRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fyn Now Seller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      onGenerateRoute: route.onGeneratedRoute,
    );
  }
}
