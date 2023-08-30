import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepal_social_app/cubit/bottom_nav_bar_cubit.dart';
import 'package:nepal_social_app/feed_page.dart';
import 'login_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userID = prefs.getString('userID');
  runApp(BlocProvider<BottomNavBarCubit>(
    create: (context) => BottomNavBarCubit(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userID == null ? LoginForm() : FeedPage(),
    ),
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nepal Social App',
//       home: const LoginForm(),
//     );
//   }
// }
