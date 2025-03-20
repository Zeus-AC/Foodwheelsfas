import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 1);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(minutes: 1));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    if (mounted) {
      setState(
        () {
          final seconds = myDuration.inSeconds - reduceSecondsBy;
          if (seconds < 0) {
            countdownTimer!.cancel();
          } else {
            myDuration = Duration(seconds: seconds);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.0),
                ),
              ),
              child: Column(
                children: [
                  backArrow(context),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(fixPadding * 2.0,
                          fixPadding / 2, fixPadding * 2.0, fixPadding * 2.0),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verificationContent(),
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            otpField(),
                            heightSpace,
                            heightSpace,
                            timer(minutes, seconds),
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            verifyButton()
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          resend(context),
        ],
      ),
    );
  }

  Widget verifyButton() {
    return GestureDetector(
      onTap: () {
        Timer(
          const Duration(seconds: 3),
          () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/bottomBar', (route) => false);
          },
        );
        pleaseWaitDialog();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: fixPadding * 1.1, horizontal: fixPadding * 2.0),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Text(
          "Verificar",
          style: bold20White,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<dynamic> pleaseWaitDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: whiteColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
                vertical: fixPadding * 3.0, horizontal: fixPadding * 2.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: primaryColor,
                  backgroundColor: primaryColor.withOpacity(0.5),
                ),
                heightSpace,
                const Text(
                  "Espere por favor",
                  style: bold20Primary,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget timer(String minutes, String seconds) {
    return Center(
      child: Text(
        "$minutes:$seconds",
        style: bold18Primary,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget otpField() {
    return Center(
      child: Pinput(
        onCompleted: (value) {
          Timer(
            const Duration(seconds: 3),
            () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/bottomBar', (route) => false);
            },
          );
          pleaseWaitDialog();
        },
        cursor: Container(
          width: 1.5,
          height: 22.0,
          color: primaryColor,
        ),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        defaultPinTheme: PinTheme(
          height: 50.0,
          width: 50.0,
          margin: const EdgeInsets.symmetric(horizontal: fixPadding / 1.5),
          textStyle: semibold18Black,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
        ),
      ),
    );
  }

  Widget verificationContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verificación",
          style: bold20Black,
        ),
        heightSpace,
        Text(
          "Le enviaremos una contraseña única a este número de móvil +91 1234567890",
          style: medium15Grey,
        )
      ],
    );
  }

  Widget backArrow(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: whiteColor,
      centerTitle: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.west_rounded,
          color: blackColor,
        ),
      ),
    );
  }

  Widget resend(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 1.5,
          fixPadding * 2.0, fixPadding * 7.5),
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          text: "¿No recibiste el código?",
          style: semibold16White.copyWith(
            color: whiteColor.withOpacity(0.7),
          ),
          children: [
            TextSpan(
              text: "Reenviar",
              style: bold16White,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (myDuration == const Duration(seconds: 0)) {
                    resetTimer();
                    startTimer();
                  }
                },
            ),
          ],
        ),
      ),
    );
  }
}
