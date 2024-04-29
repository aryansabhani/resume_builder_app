
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder_app/view/screens/showResumeScreen.dart';


class AnimatedSplas extends StatefulWidget {
  const AnimatedSplas({super.key});

  @override
  State<AnimatedSplas> createState() => _AnimatedSplasState();
}

class _AnimatedSplasState extends State<AnimatedSplas> {
  // inquriry_controller controller = Get.put(inquriry_controller());


  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: s.height * 0.2,
        splash: Image.asset(
          "asstes/image/img.png",
          fit: BoxFit.fitWidth,
        ),
        nextScreen: ShowAllResumeScreen(),
      ),
      backgroundColor: Colors.black,
    );
  }
}
