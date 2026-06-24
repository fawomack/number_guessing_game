// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle

// --- CENTRALIZED GATOR BRANDING THEME CONSTANTS ---
class GatorTheme {
  // --- MASTER BRAND COLOR HEX REGISTRY ---
  static const Color royalBlue = Color(0xFF0021A5); // The official high-saturation signature Gator Royal Blue base
  static const Color darkNavy = Color(0xFF0A1E3F); // The deep athletic stadium navy gradient terminal cap
  static const Color vividOrange = Color(0xFFFA4616); // The primary high-vibrancy neon orange action color
  static const Color versusBlue = Color(0xFF4FA3FF); // The specialized electric sky blue variant for versus UI elements

  // --- REUSABLE SYSTEM LAYOUT GEOMETRY CONFIGURATIONS ---
  static const double buttonRadius = 30.0; // Sets a unified master capsule border radius for primary screen actions
  static const double glassRadius = 24.0; // Enforces a continuous smooth corner curvature profile for dashboard cards

  // --- GLOBAL UNIFIED BACKGROUND BACKDROP DESIGN LAYOUT ---
  static const BoxDecoration screenGradientBackground = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        royalBlue, // Pulls the centralized royal blue constant into the starting layout position
        darkNavy, // Anchors the dark athletic navy constant down at the bottom margin edge
      ],
      begin: Alignment.topCenter, // Locks the continuous color shifting linear transformation vector to top center
      end: Alignment.bottomCenter, // Drops the destination color terminal point directly to the lower boundary
    ),
  );
}