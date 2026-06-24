// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports Flutter's UI framework packages (contains all layout blocks like Buttons, Columns, and Colors)
import 'theme/gator_theme.dart'; // Injects the central source of truth for all Gator brand asset configurations
import 'screens/main_menu_screen.dart'; // Imports your custom home screen file so this script can launch it as the starting window

// --- APPLICATION HARDWARE ENTRY POINT ---
void main() {
  runApp(const MyApp()); // Launches the core Flutter layout engine and mounts your custom master widget (MyApp) onto the screen
}

// --- MASTER ROOT CONFIGURATION LAYER ---
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor rule that optimizes memory management when rendering this widget tree hierarchy

  @override // Instructs the compiler to override standard root rendering methods
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guessing Game', // Operating system task label configuration metadata
      debugShowCheckedModeBanner: false, // Hides the bright red "DEBUG" banner from Chrome's top right corner
      theme: ThemeData(
        brightness: Brightness.dark, // Switches default framework system calculations to support a rich dark mode setup
        scaffoldBackgroundColor: GatorTheme.darkNavy, // Links the base structural background fallback to your central dark navy property constant
        colorScheme: ColorScheme.fromSeed(
          seedColor: GatorTheme.royalBlue, // Hooks the theme generation engine directly into your centralized royal blue color map
          brightness: Brightness.dark, // Signals the framework engine to auto-generate dark layout color configurations natively
          secondary: GatorTheme.vividOrange, // Maps your signature high-vibrancy orange constant as the master secondary accent tracking point
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: GatorTheme.vividOrange, // Injects your centralized vibrant orange accent color directly onto solid button backgrounds
            foregroundColor: Colors.white, // Paints typography elements inside solid buttons a solid bright white
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.8), // Enforces bold global text properties and tight tracking spaces
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(GatorTheme.buttonRadius)), // Feeds the centralized button corner curvature parameter down globally
            elevation: 4, // Adds subtle depth by casting a soft shadow profile underneath clickable surfaces
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white24, width: 1.5), // Softens the harsh white outline down to a subtle twenty-four percent opacity frame line
            foregroundColor: Colors.white, // Keeps character typography elements tracking across hollow buttons fully solid white
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.8), // Pairs font sizes perfectly with the primary actions configuration
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(GatorTheme.buttonRadius)), // Syncs secondary hollow action border curves with your master radius property
          ),
        ),
      ),
      home: const MainMenuScreen(), // Directs the app's internal navigation system on which file layout screen component to draw as the home page
    );
  }
}