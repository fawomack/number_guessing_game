// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle
import '../theme/gator_theme.dart'; // References the master design system token profile file
import '../screens/versus_game_screen.dart'; // Grants direct visibility structural links into your VersusAttempt data model object maps

// --- REUSABLE GLASSMORPHIC ARENA HISTORY ROW BUILDER ---
class VersusHistoryRow extends StatelessWidget {
  // --- INJECTED ROW PROPERTIES PROPERTY REGISTRY ---
  final VersusAttempt attempt; // Active historical attempt instance parameters properties data profile map
  final int currentRound; // Current operational match round tracking pointer to align dynamic role text swaps

  const VersusHistoryRow({
    super.key, // Configures standard foundational constructor parsing key variables
    required this.attempt,
    required this.currentRound,
  });

  // --- ITEM CELL VIEWPORT DRAW OPERATIONS ---
  @override
  Widget build(BuildContext context) {
    // Determine active layout roles dynamically relative to active operational match sequences
    final String activeGuesser = currentRound == 1 ? "Player 2" : "Player 1";
    final Color itemAccent = currentRound == 1 ? GatorTheme.versusBlue : GatorTheme.vividOrange;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6), // Gaps out vertical items log cells cleanly along lists tracks
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Internal tracking lists cell borders cushion lines
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GatorTheme.glassRadius), // Clips container fields inside master theme curve values
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.06), // Subtle frosting overlays profile records maps
            Colors.white.withValues(alpha: 0.02), // Transparent base values boundaries
          ],
        ),
        border: Border.all(
          color: attempt.feedback.contains('Hit') 
              ? Colors.greenAccent.withValues(alpha: 0.2) // Glow emerald on a target confirmation strike hit vector
              : itemAccent.withValues(alpha: 0.15), // Matches standard theme role color profiles for direction warnings
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes match tracking indices to opposite poles cleanly across the horizon axis
        children: [
          // --- GUESS VAL DATA DATA ELEMENT LABEL ---
          Text(
            '$activeGuesser guessed: ${attempt.guess}', // Renders the exact data integer entry tracking string configuration
            style: const TextStyle(
              color: Colors.white, // Solid bright white layout-wide font characters sets
              fontSize: 15, // Scannable high visibility list dimensions points
              fontWeight: FontWeight.bold, // Bold emphasis weight mapping rules
            ),
          ),

          // --- DIRECTIONAL MATRIX ALERTS TAG ---
          Text(
            attempt.feedback, // Displays dynamic too high, too low, or hit alerts tags variables data
            style: TextStyle(
              color: attempt.feedback.contains('Hit') ? Colors.greenAccent : itemAccent, // Lights up wins in emerald and parameters in stadium accents
              fontSize: 15, // Matching tracking font size dimensions
              fontWeight: FontWeight.w600, // Semi bold configuration priority layout mapping tracks
            ),
          ),
        ],
      ),
    );
  }
}