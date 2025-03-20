import 'package:flutter/material.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationOn = true;

  bool isShareLocation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.west,
            color: blackColor,
          ),
        ),
        title: const Text(
          "Configuraciones",
          style: bold18Black,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding / 2,
            fixPadding * 2.0, fixPadding * 2.0),
        children: [
          settingsWithSwitch("Notificaciones", isNotificationOn, () {
            setState(() {
              isNotificationOn = !isNotificationOn;
            });
          }),
          heightSpace,
          heightSpace,
          settingsWithSwitch("Acepto compartir mi ubicación", isShareLocation,
              () {
            setState(() {
              isShareLocation = !isShareLocation;
            });
          }),
          heightSpace,
          heightSpace,
          clearCache()
        ],
      ),
      bottomNavigationBar: saveButton(),
    );
  }

  Widget saveButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        padding: const EdgeInsets.symmetric(
            vertical: fixPadding * 1.3, horizontal: fixPadding * 2.0),
        width: double.maxFinite,
        color: primaryColor,
        child: const Text(
          "Guardar",
          style: bold18White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget clearCache() {
    return Container(
      padding: const EdgeInsets.all(fixPadding * 1.5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: boxShadow,
      ),
      child: const Text(
        "Borrar caché",
        style: medium16Black,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget settingsWithSwitch(String title, bool value, Function() onTap) {
    return Container(
      padding: const EdgeInsets.all(fixPadding * 1.5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: boxShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: medium16Black,
            ),
          ),
          width5Space,
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 35.0,
              height: 20.0,
              padding: const EdgeInsets.symmetric(horizontal: fixPadding * 0.3),
              decoration: BoxDecoration(
                color: value ? primaryColor : greyD9Color,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 30),
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  height: 14.0,
                  width: 14.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: whiteColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
