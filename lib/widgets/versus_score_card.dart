// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle
import '../theme/gator_theme.dart'; // References the master design system token profile file

// --- REUSABLE GLASSMORPHIC COMPONENT GRID ELEMENT ---
class VersusScoreCard extends StatelessWidget {
  // --- COMPONENT PARAMETER CORES REGISTRY ---
  final String player; // Name designation identification string mapping (e.g. 'PLAYER 1')
  final int score; // Accumulated match series victories integer score tracks
  final String details; // Secondary running context sub-label text string maps (e.g. 'Guesses: 4')
  final Color color; // Assigned player signature canvas theme accent color token

  const VersusScoreCard({
    super.key, // Configures foundational constructor key tracking references
    required this.player,
    required this.score,
    required this.details,
    required this.color,
  });

  // --- COMPONENT FRAME VISUAL ENGINE DRAW ROUTINES ---
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8), // Balances interior typography positions layout wide
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GatorTheme.glassRadius), // Connects scorecard elements cleanly to our master glass curve token
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.08), // Glazes base layers with thin transparency maps
              Colors.white.withValues(alpha: 0.02), // Fades bottom plate boundaries softly out of view fields
            ],
          ),
          border: Border.all(
            color: color.withValues(alpha: 0.25), // Tint borders cleanly with player-specific contextual team color variables
            width: 1.5, // Thickens scorecard borders slightly to stand out as distinct elements
          ),
        ),
        child: Column(
          children: [
            // --- HEADER TITLE TRACK LABEL ---
            Text(
              player, // Draws player identification name strings literal data
              style: const TextStyle(
                color: Colors.white60, // Mutes metadata headers to secondary focal priority
                fontSize: 11, // Small crisp caption scaling parameters
                fontWeight: FontWeight.bold, // Bolds name fields
                letterSpacing: 1.0, // Spreads tracking maps modernly
              ),
            ),
            const SizedBox(height: 4), // Interior structural stack spacing clearance buffer

            // --- CRITICAL MATCH SERIES SCORE READOUT ---
            Text(
              '$score WINS', // Prints structural cumulative match score tracking metrics
              style: TextStyle(
                color: color, // Highlights active score readouts matching assigned operational color context lines
                fontSize: 20, // Punchy readable scoring scale factor units
                fontWeight: FontWeight.w900, // Forces maximum visual density for critical scores parameters
                letterSpacing: 1.0, // Spreads technical tracking tracking parameters
              ),
            ),
            const SizedBox(height: 4), // Interior technical layout padding buffer gap

            // --- DYNAMIC PHASE DATA SUBMETRICS HEADER ---
            Text(
              details, // Renders live active running hunt details data maps safely
              style: const TextStyle(
                color: Colors.white38, // Mutes contextual layout parameters deeply into the background layer
                fontSize: 11, // Matching small functional subtext sizing footprint
                fontWeight: FontWeight.w500, // Balanced tracking font weight configuration
              ),
            ),
          ],
        ),
      ),
    );
  }
}