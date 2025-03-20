import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/typcn.dart';
import 'package:pn_fl_foody_delivery/screens/screens.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  DateTime? backPressTime;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const WalletScreen(),
      const HistoryScreen(),
      const ProfileScreen(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        bool backStatus = onPopScope();
        if (backStatus) {
          exit(0);
        }
      },
      child: Scaffold(
        body: pages.elementAt(selectedIndex),
        bottomNavigationBar: bottomBar(context),
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: boxShadow,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: whiteColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          elevation: 0.0,
          selectedFontSize: 0,
          items: [
            itemWidget(Typcn.home),
            itemWidget(Ph.wallet_fill),
            itemWidget(MaterialSymbols.history),
            itemWidget(Mdi.user),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem itemWidget(String icon) {
    return BottomNavigationBarItem(
      icon: Container(
        height: 40.0,
        width: 40.0,
        margin: const EdgeInsets.symmetric(vertical: fixPadding),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Iconify(
          icon,
          color: greyColor,
          size: 26.0,
        ),
      ),
      activeIcon: Container(
        height: 40.0,
        width: 40.0,
        margin: const EdgeInsets.symmetric(vertical: fixPadding),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor,
        ),
        alignment: Alignment.center,
        child: Iconify(
          icon,
          color: whiteColor,
          size: 24.0,
        ),
      ),
      label: "",
    );
  }

  onPopScope() {
    DateTime now = DateTime.now();
    if (backPressTime == null ||
        now.difference(backPressTime!) >= const Duration(seconds: 2)) {
      backPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: blackColor,
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1500),
          content: Text(
            "Presione Atrás una vez más para salir",
            style: semibold16White,
          ),
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}
