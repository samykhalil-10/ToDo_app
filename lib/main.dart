
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/app_routes.dart';
import 'package:todo/core/theme/app_theme.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/ui/auth/login/login_screen.dart';
import 'package:todo/ui/auth/register/register_screen.dart';
import 'package:todo/ui/home/add_tasks_bottom_sheet.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/spalsh/spalsh_screen.dart';

import 'providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppAuthProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()), // Add SettingsProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.currentTheme,
      onGenerateRoute: (settings) {
        print(settings.name);
        switch (settings.name) {
          case AppRoutes.homeRoute:
            {
              return MaterialPageRoute(
                builder: (context) => HomeScreen(),
              );
            }
          case AppRoutes.registerRoute:
            {
              return MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              );
            }
          case AppRoutes.loginRoute:
            {
              return MaterialPageRoute(
                builder: (context) => LoginScreen(),
              );
            }
          case AppRoutes.splashRoute:
            {
              return MaterialPageRoute(
                builder: (context) => SplashScreen(),
              );
            }
        }
        return null;
      },
      initialRoute: AppRoutes.splashRoute,
    );
  }
}