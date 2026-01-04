import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv
import 'screens/splash_screen.dart';
import 'services/cart_service.dart'; // Import the new CartService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the entire app with a ChangeNotifierProvider.
    // This makes the CartService available to all widgets in the app.
    return ChangeNotifierProvider(
      create: (context) => CartService(),
      child: MaterialApp(
        title: 'Manchester United',
        theme: ThemeData(
          // Manchester United Official Colors
          colorScheme: ColorScheme.light(
            primary: const Color(0xFFDA291C), // Official MU Red
            secondary: const Color(0xFFFDB913), // Gold accent
            surface: Colors.white,
            background: const Color(0xFFF5F5F5),
            error: Colors.red.shade700,
          ),

          // AppBar Theme
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFDA291C), // MU Red
            foregroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),

          // Bottom Navigation Bar Theme
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFFDA291C), // MU Red
            unselectedItemColor: Color(0xFF666666),
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: TextStyle(fontSize: 11),
            showUnselectedLabels: true,
            elevation: 8,
          ),

          // Card Theme
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),

          // Text Theme
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000),
            ),
            headlineMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000),
            ),
            headlineSmall: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000),
            ),
            titleLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF000000),
            ),
            titleMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
            bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF333333)),
            bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF666666)),
          ),

          // Use Material 3
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
