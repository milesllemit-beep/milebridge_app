import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// Screen Imports
import 'screens/welcome_screen.dart';
import 'screens/register_screen.dart';
// import 'screens/verification_screen.dart'; // Keep commented until file is ready
import 'screens/dashboard_screen.dart';
import 'screens/translator_screen.dart';
import 'screens/learn_menu_screen.dart';
import 'screens/messenger_bridge_screen.dart';
import 'screens/emotional_support_screen.dart';
import 'screens/location_modes_screen.dart';

void main() async {
  // 1. Ensure Flutter bindings are initialized for native tools (Camera/Storage)
  WidgetsFlutterBinding.ensureInitialized();
  
  List<CameraDescription> cameras = [];
  try {
    // 2. Fetch the list of available cameras on the device/emulator
    cameras = await availableCameras();
  } catch (e) {
    debugPrint("Camera Initialization Error: $e");
  }

  runApp(MileBridgeApp(cameras: cameras));
}

class MileBridgeApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  
  const MileBridgeApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MileBridge AI',
      
      // 3. Modern Tech-Focused Theme Setup
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat', // Ensuring consistency with your design goals
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF008080), // Your primary Teal
          primary: const Color(0xFF008080),
          secondary: const Color(0xFF004D40),
        ),
        scaffoldBackgroundColor: const Color(0xFFE8F6F8),
        
        // Setting a clean, professional style for all AppBars
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // 4. Navigation Routing
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        
        // Passing the camera list to the translator
        '/translator': (context) => TranslatorScreen(cameras: cameras),
        
        '/learn': (context) => const LearnMenuScreen(),
        '/messenger': (context) => const MessengerBridgeScreen(),
        
        // If your Support screen eventually uses AI Vision, pass cameras there too
        '/support': (context) => const EmotionalSupportScreen(),
        
        '/modes': (context) => const LocationModesScreen(),

        // FIXED: Gidugang kini nga mga rota aron dili na mo-crash kung i-tap ang mga menu cards
        '/alphabet': (context) => const LearnMenuScreen(), // Ilisi ni og AlphabetScreen() puhon
        '/words': (context) => const LearnMenuScreen(),    // Ilisi ni og WordsScreen() puhon
        '/phrases': (context) => const LearnMenuScreen(),  // Ilisi ni og PhrasesScreen() puhon
      },
    );
  }
}