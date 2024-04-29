import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder_app/controller/resumeController.dart';
import 'package:resume_builder_app/view/screens/addResumePage.dart';
import 'package:resume_builder_app/view/screens/showResumeScreen.dart';
import 'package:resume_builder_app/view/screens/splashScreen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ResumeController(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // appBarTheme: AppBarTheme(color: )
      ),
      // darkTheme: ThemeData(useMaterial3: true),
      routes: {
        '/': (context) => AnimatedSplas(),
        'main_page': (context) => ShowAllResumeScreen(),
        'add_page': (context) => AddResumePage(),
      },
    );
  }
}
