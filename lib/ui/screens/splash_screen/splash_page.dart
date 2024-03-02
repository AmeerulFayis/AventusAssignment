import 'dart:async';

import 'package:flutter/material.dart';

import '../../../util/app_color.dart';
import '../../../util/app_constants.dart';
import '../home_screen/home_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    });
  }
  Widget build(BuildContext context) {
    return  Scaffold(
     body:  SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: commonPaddingAll30,
                child: const Text("Todo App",style:TextStyle(
                    color: AppColor.darkGreen,fontWeight: FontWeight.bold,fontSize: 35
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
