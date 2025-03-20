import 'package:flutter/material.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
          "Política de Privacidad",
          style: bold18Black,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding / 2,
            fixPadding * 2.0, fixPadding * 2.0),
        children: const [
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sem maecenas proin nec, turpis iaculiviver ramalesuada lacus.Lorem ipsum dolor sit amet, consectetuadipiscing elit. Sem maecenas proin nec, turpis iaculiviv erramassa malesuada lacus. Lorem ipsum dolor siamet,consectetur adipiscing elit. Sem maecenas proin turpis iaculiviverra massa malesuada lacus.nec, turpis iaculiviverramassal.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sem maecenas proin nec, turpis iaculiviver ramalesuada lacus.Lorem ipsum dolor sit amet, consectetuadipiscing elit. Sem maecenas proin nec, turpis iaculiviv erramassa malesuada lacus. Lorem ipsum dolor siamet,consectetur adipiscing elit. Sem maecenas proin turpis iaculiviverra massa malesuada lacus.nec, turpis iaculiviverramassal.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sem maecenas proin nec, turpis iaculiviver ramalesuada lacus.Lorem ipsum dolor sit amet, consectetuadipiscing elit. Sem maecenas proin nec, turpis iaculiviv erramassa malesuada lacus. Lorem ipsum dolor siamet,consectetur adipiscing elit. Sem maecenas proin turpis iaculiviverra massa malesuada lacus.nec, turpis iaculiviverramassal.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sem maecenas proin nec, turpis iaculiviver ramalesuada lacus.Lorem ipsum dolor sit amet, consectetuadipiscing elit. Sem maecenas proin nec, turpis iaculiviv erramassa malesuada lacus. Lorem ipsum dolor siamet,consectetur adipiscing elit. Sem maecenas proin turpis iaculiviverra massa malesuada lacus.nec, turpis iaculiviverramassal.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sem maecenas proin nec, turpis iaculiviver ramalesuada lacus.Lorem ipsum dolor sit amet, consectetuadipiscing elit. Sem maecenas proin nec, turpis iaculiviv erramassa malesuada lacus. Lorem ipsum dolor siamet,consectetur adipiscing elit. Sem maecenas proin turpis iaculiviverra massa malesuada lacus.nec, turpis iaculiviverramassal.",
            style: semibold14Grey,
          ),
        ],
      ),
    );
  }
}
