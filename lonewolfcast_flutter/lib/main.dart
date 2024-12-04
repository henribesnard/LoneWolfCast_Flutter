import 'package:flutter/material.dart';
import 'package:lonewolfcast_flutter/shared/widgets/bottom_nav_bar.dart';
import 'package:lonewolfcast_flutter/features/home/screens/home_screen.dart';
import 'package:lonewolfcast_flutter/features/bankroll/screens/bankroll_screen.dart';
import 'package:lonewolfcast_flutter/features/settings/screens/settings_screen.dart';
import 'package:lonewolfcast_flutter/core/config/env_config.dart';
import 'package:lonewolfcast_flutter/features/home/navigation/match_navigation.dart';  // Ajouté

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await EnvConfig.load();
    print('Environnement chargé avec succès');
    print('Nombre de leagues configurées: ${EnvConfig.leagues.length}');
  } catch (e) {
    print('Erreur lors du chargement de l\'environnement: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MatchNavigation.onGenerateRoute,  // Utilisé maintenant que l'import est présent
      navigatorKey: GlobalKey<NavigatorState>(),  // Ajouté pour la navigation globale
      title: 'LoneWolfCast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const BankrollScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}