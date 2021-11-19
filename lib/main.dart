import 'package:flutter/material.dart';
import 'package:histo_view/views/forgot_password_view.dart';
import 'package:histo_view/views/login_view.dart';
import 'package:histo_view/views/register_view.dart';
import 'package:histo_view/views/tab_bar_view.dart';
import 'package:histo_view/views/tabs/favorite/favorite_view.dart';
import 'package:histo_view/views/tabs/map/map_view.dart';
import 'package:histo_view/views/tabs/profile/edit_profile_view.dart';
import 'package:histo_view/views/tabs/profile/profile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HistoView',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/tabBar',
      routes: {
        '/': (context) => LoginView(),
        '/login': (context) => LoginView(),
        '/register': (context) => const RegisterView(),
        '/forgotPassword': (context) => ForgotPasswordView(),
        '/tabBar': (context) => const TabBarAppView(),
        '/editProfile': (context) => const EditProfileView(),
        /*'/map': (context) => const MapView(),
        '/favorite': (context) => const FavoriteView(),
        '/profile': (context) => ProfileView(),*/
      },
    );
  }
}
