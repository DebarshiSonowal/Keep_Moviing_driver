import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/auth/loginScreen.dart';
import 'package:my_cab_driver/setting/settingScreen.dart';
import 'package:my_cab_driver/splashScreen.dart';
import 'appTheme.dart';
import 'auth/signUpScreen.dart';
import 'firebase_options.dart';
import 'history/historyScreen.dart';
import 'home/homeScreen.dart';
import 'introduction/LocationScreen.dart';
import 'introduction/introductionScreen.dart';
import 'inviteFriend/inviteFriendScreen.dart';
import 'notification/notificationScree.dart';
import 'package:my_cab_driver/wallet/myWallet.dart';
import 'constance/constance.dart' as constance;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(new MyApp()));
}

class MyApp extends StatefulWidget {
  static setCustomeTheme(BuildContext context, int index) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setCustomeTheme(index);
  }

  static setCustomeLanguage(BuildContext context, String languageCode) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLanguage(languageCode);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  setCustomeTheme(int index) {
    if (index == 6) {
      setState(() {
        AppTheme.isLightTheme = true;
      });
    } else if (index == 7) {
      setState(() {
        AppTheme.isLightTheme = false;
      });
    } else {
      setState(() {
        constance.colorsIndex = index;
        constance.primaryColorString = ConstanceData().colors[constance.colorsIndex];
        constance.secondaryColorString = constance.primaryColorString;
      });
    }
  }

  String locale = "en";

  setLanguage(String languageCode) {
    setState(() {
      locale = languageCode;
      constance.locale = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    constance.locale = locale;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
      statusBarBrightness: AppTheme.isLightTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: AppTheme.isLightTheme ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
    ));
    return MaterialApp(
      title: 'MyCab Driver',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      routes: routes,
    );
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.INTRODUCTION: (BuildContext context) => new IntroductionScreen(),
    Routes.ENABLELOCATION: (BuildContext context) => new EnableLocation(),
    Routes.AUTH: (BuildContext context) => new SignUpScreen(),
    Routes.HOME: (BuildContext context) => new HomeScreen(),
    Routes.HISTORY: (BuildContext context) => new HistoryScreen(),
    Routes.NOTIFICATION: (BuildContext context) => new NotificationScreen(),
    Routes.INVITE: (BuildContext context) => new InviteFriendScreen(),
    Routes.SETTING: (BuildContext context) => new SettingScreen(),
    Routes.WALLET: (BuildContext context) => new MyWallet(),
    Routes.LOGIN: (BuildContext context) => new LoginScreen(),
  };
}

class Routes {
  static const String SPLASH = "/";
  static const String INTRODUCTION = "/introduction/introductionScreen";
  static const String ENABLELOCATION = "/introduction/LocationScreen";
  static const String AUTH = "/auth/signUpScreen";
  static const String LOGIN = "/auth/loginScreen";
  static const String HOME = "/home/homeScreen";
  static const String HISTORY = "/history/historyScreen";
  static const String NOTIFICATION = "/notification/notificationScree";
  static const String INVITE = "/inviteFriend/inviteFriendScreen";
  static const String SETTING = "/setting/settingScreen";
  static const String WALLET = "/wallet/myWallet";
}
