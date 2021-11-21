import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:histo_view/views/account_created_view.dart';
import 'package:histo_view/views/forgot_password_view.dart';
import 'package:histo_view/views/login_view.dart';
import 'package:histo_view/views/register_view.dart';
import 'package:histo_view/views/tab_bar_view.dart';
import 'package:histo_view/views/tabs/profile/edit_profile_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/forgotPassword': (context) => ForgotPasswordView(),
        '/tabBar': (context) => const TabBarAppView(),
        '/editProfile': (context) => const EditProfileView(),
        '/accountCreated': (context) => const AccountCreatedView(),
      },
    );
  }
}
