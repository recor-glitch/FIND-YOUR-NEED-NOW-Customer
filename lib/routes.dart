import 'package:demoecommerce/screens/auth/confirm_otp_page.dart';
import 'package:demoecommerce/screens/auth/forgot_password_page.dart';
import 'package:demoecommerce/screens/auth/register_page.dart';
import 'package:demoecommerce/screens/auth/welcome_back_page.dart';
import 'package:demoecommerce/screens/intro_page.dart';
import 'package:demoecommerce/screens/splash_page.dart';
import 'package:flutter/material.dart';

class AutoRouter {
  Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => WelcomeBackPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/intro':
        return MaterialPageRoute(builder: (_) => IntroPage());
      case '/otp':
        var phn = settings.arguments;
        return MaterialPageRoute(builder: (_) => ConfirmOtpPage(phn: phn));
      case '/phn':
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      default:
        return null;
    }
  }
}
