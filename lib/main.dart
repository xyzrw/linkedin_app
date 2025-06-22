import 'package:flutter/material.dart';
import 'package:linkedin_app/utils/consts.dart';
import 'package:linkedin_app/viewmodels/auth_viewmodel.dart';
import 'package:linkedin_app/viewmodels/post_viewmodel.dart';
import 'package:linkedin_app/viewmodels/profile_viewmodel.dart';
import 'package:linkedin_app/views/auth_home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewmodel()),
        ChangeNotifierProvider(create: (_) => ProfileViewmodel()),
        ChangeNotifierProvider(create: (_) => PostViewmodel()),
      ],
      child: MaterialApp(
        title: 'Linkedin App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          cardTheme: CardTheme(color: Colors.white),
          scaffoldBackgroundColor: Color.fromRGBO(247, 250, 252, 1),
        ),
        home: AuthHome(),
      ),
    );
  }
}
