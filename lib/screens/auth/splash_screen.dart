import 'package:flutter/material.dart';
import 'package:news_app/firebase_services/SplashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final splash_service=Splashservices();

  @override
  void initState() {
    // TODO: implement initState
    splash_service.isLogin(context);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}