import 'package:assignment/src/constants/color_constants.dart';
import 'package:assignment/src/constants/string_constants.dart';
import 'package:assignment/src/routing/routing_config.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// BotToast Initialize
    final botToastBuilder = BotToastInit();

    /// System Orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp.router(
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: ColorConstants.primary),
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primary),
        useMaterial3: true,
      ),
      routerConfig: RoutingConfig.router,
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
    );
  }
}
