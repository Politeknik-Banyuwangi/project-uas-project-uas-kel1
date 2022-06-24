import 'package:flutter/material.dart';
import 'package:projectuas/pages/home.dart';
import 'package:projectuas/pages/presence_detail.dart';
import 'package:projectuas/pages/presence_history.dart';
import 'package:projectuas/pages/signin.dart';
import 'package:projectuas/pages/splash.dart';
import 'main_page.dart';

Map<String, WidgetBuilder> buildRouter(BuildContext context) {
  return {
    'page': (context) => MainPage(),
    '/home': (context) => HomeScreen(),
    '/login': (context) => SignInScreen(),
    '/presence-history': (context) => PresenceHistoryScreen(),
    '/splash': (context) => SplashScreen(),
  };
}
