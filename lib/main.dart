import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_express/provider/login_provider.dart';
import 'package:food_express/screen/splash/splash_page.dart';
import 'package:food_express/utils/app_colors.dart';
import 'package:food_express/utils/pref_utils.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtils.initInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final alice = Alice(showNotification: true);

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.GREY));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'Food Express',
        navigatorKey: MyApp.alice.getNavigatorKey(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: AppColors.GREY,
            primaryColorDark: AppColors.LIGHT_GREY,
            primaryIconTheme: IconThemeData(color: AppColors.ICON_COLOR, size: 16),
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(background: Colors.white)),
        home: const SplashPage(),
      ),
    );
  }
}
