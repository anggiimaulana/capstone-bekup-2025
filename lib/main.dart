import 'package:capstone/firebase_options.dart';
import 'package:capstone/provider/destination_provider.dart';
import 'package:capstone/provider/favorite_provider.dart';
import 'package:capstone/provider/gemini_provider.dart';
import 'package:capstone/provider/theme_provider.dart';
import 'package:capstone/screen/bottom_navigation.dart';
import 'package:capstone/screen/chatbot/chatbot_screen.dart';
import 'package:capstone/screen/login/login_screen.dart';
import 'package:capstone/screen/setting/setting_screen.dart';
import 'package:capstone/service/auth_service.dart';
import 'package:capstone/service/favorite_service.dart';

import 'package:capstone/service/gemini_service.dart';
import 'package:capstone/utils/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GeminiService>(create: (_) => GeminiService()),

        // Gemini provider
        ChangeNotifierProvider<GeminiProvider>(
          lazy: false,
          create: (context) => GeminiProvider(context.read<GeminiService>()),
        ),

        // Auth & Favorite services
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FavoriteService>(create: (_) => FavoriteService()),

        // Theme provider
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider()..loadTheme(),
        ),

        // Destination provider
        ChangeNotifierProvider<DestinationProvider>(
          create: (_) => DestinationProvider(),
        ),

        // Favorite provider
        ChangeNotifierProvider<FavoriteProvider>(
          create: (context) => FavoriteProvider(
            context.read<AuthService>(), 
            context
                .read<
                  FavoriteService
                >(), 
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'WisataKu',
            debugShowCheckedModeBanner: false,
            navigatorKey:
                GeminiProvider.navigatorKey,
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.light,
              fontFamily: 'Inter',
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF0077BE),
                brightness: Brightness.light,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.dark,
              fontFamily: 'Inter',
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF0077BE),
                brightness: Brightness.dark,
              ),
            ),
            home: const AuthWrapper(),
            routes: {
              '/login': (_) => const LoginScreen(),
              '/home': (_) => const BottomNavigation(),
              '/settings': (_) => const SettingsScreen(),
              '/enhanced-chat': (_) => const ChatbotScreen(),
            },
          );
        },
      ),
    );
  }
}
