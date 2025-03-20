import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pn_fl_foody_delivery/screens/screens.dart';
import 'package:pn_fl_foody_delivery/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura la inicialización correcta de Flutter antes de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Foody Delivery',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
          ),
          primaryColor: primaryColor,
          useMaterial3: true,
          fontFamily: 'Mulish',
          scaffoldBackgroundColor: whiteColor,
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: primaryColor,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            prefixIconColor: WidgetStateColor.resolveWith(
              (states) => states.contains(WidgetState.focused)
                  ? primaryColor
                  : greyColor,
            ),
          ),
        ),
        home: const SplashScreen(),
        onGenerateRoute: routes,
      ),
    );
  }

  Route<dynamic>? routes(settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/signin':
        return PageTransition(
          child: const SignInScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/signup':
        return PageTransition(
          child: const SignUpScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/verification':
        return PageTransition(
          child: const VerificationScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/bottomBar':
        return PageTransition(
          child: const BottomBar(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/home':
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/orderDetail':
        return PageTransition(
          child: const OrderDetailScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/trackOrder':
        return PageTransition(
          child: const TrackOrderScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/chat':
        return PageTransition(
          child: const ChatScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/wallet':
        return PageTransition(
          child: const WalletScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/history':
        return PageTransition(
          child: const HistoryScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/Profile':
        return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/notification':
        return PageTransition(
          child: const NotificationScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/editProfile':
        return PageTransition(
          child: const EditProfileScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/settings':
        return PageTransition(
          child: const SettingsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/termsAndCondition':
        return PageTransition(
          child: const TermsAndConditionScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/privacyPolicy':
        return PageTransition(
          child: const PrivacyPolicyScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/helpAndSupport':
        return PageTransition(
          child: const HelpAndSupportScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      default:
        return null;
    }
  }
}
