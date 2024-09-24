import 'package:flutter/material.dart';
import 'package:flutter_tech_challenge/src/core/core.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushNamed(
      // ignore: use_build_context_synchronously
      context,
      '/home',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDarkGrey,
      body: Center(
        child: Image.asset(
          AppImages.logo,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
