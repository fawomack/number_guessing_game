// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports core Material graphics library bundles
import '../theme/gator_theme.dart'; // References centralized tokens profile file
import '../screens/versus_game_screen.dart'; // Injects data structure classes maps visibility safely

// --- REUSABLE GLASSMORPHIC ARENA HISTORY ROW BUILDER ---
class VersusHistoryRow extends StatelessWidget {
  // --- INJECTED ROW PROPERTIES REGISTRY ---
  final VersusAttempt attempt; // Active attempt structural data map properties profile
  final String guesserName; // Overridden text name parameter mapping roles cleanly inside side-by-side matrices

  const VersusHistoryRow({
    super.key, // Standard key binding tracks parsing constructors
    required this.attempt,
    required this.guesserName,
  });

  // --- ITEM CELL VIEWPORT DRAW OPERATIONS ---
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4), // Consolidated tighter grid row heights gaps
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), // Tighter padding bounding metrics inside items cells
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GatorTheme.glassRadius), // Ties curves directly into global system specifications
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.01),
          ],
        ),
        border: Border.all(
          color: attempt.alertColor.withValues(alpha: 0.2), // FIX 3: Fully responsive custom structural side borders mapping outcomes
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- STRUCTURAL GUESS METRIC DISPLAY ---
          Text(
            '${attempt.guess}', // Renders the bare raw submitted guess number cleanly
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          // --- DYNAMIC DIRECTION TEXT LABELS WITH TINTS ---
          Text(
            attempt.feedback, // FIX 3: Renders arrow direction strings (e.g. "Too Low ↑") matching color codes
            style: TextStyle(
              color: attempt.alertColor, // Dynamically updates text coloring profile contextually without emojis
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}