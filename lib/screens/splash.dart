import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              bgImage(size),
              appLogo(),
              const Positioned(
                bottom: 20.0,
                left: 0,
                right: 0,
                child: Text(
                  "Delivery App",
                  style: extrabold18White,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget appLogo() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Center(
            child: Container(
              height: 203.0,
              width: 200.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/splash/ring.png"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                height: 105.0,
                width: 105.0,
                padding: const EdgeInsets.all(fixPadding / 2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: whiteColor,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryColor, width: 1.2),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "TezoEats", //NOMBRE EN LA PORTADA DE INICIO DE SESION
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 26.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'LilyScriptOne'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bgImage(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/splash/topImage.png",
          fit: BoxFit.cover,
          width: double.maxFinite,
          height: size.height * 0.3,
          alignment: Alignment.bottomCenter,
          opacity: const AlwaysStoppedAnimation(0.2),
        ),
        Transform.flip(
          flipX: true,
          flipY: true,
          child: Image.asset(
            "assets/splash/topImage.png",
            fit: BoxFit.cover,
            width: double.maxFinite,
            height: size.height * 0.3,
            alignment: Alignment.bottomCenter,
            opacity: const AlwaysStoppedAnimation(0.2),
          ),
        ),
      ],
    );
  }
}
