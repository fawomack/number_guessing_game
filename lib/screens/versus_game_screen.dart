// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle
import 'dart:math'; // Imports the math engine bundle to capture random range generations
import '../theme/gator_theme.dart'; // References the master design system token profile file

// --- VERSUS COMPETITIVE ARENA GAMEPLAY CONTROLLER ---
class VersusGameScreen extends StatefulWidget {
  const VersusGameScreen({super.key}); // Configures the standard foundational constructor passing structural key trackers

  @override
  State<VersusGameScreen> createState() => _VersusGameScreenState(); // Instantiates the dynamic mutable state engine for this screen
}

class _VersusGameScreenState extends State<VersusGameScreen> {
  // --- STATE REGISTRATION FIELD TRACKERS ---
  final TextEditingController _versusController = TextEditingController(); // Allocates the memory stream to capture competitive player entry text
  late int _targetNumber; // The secret target value generated for the ongoing interactive turn
  int _player1Score = 0; // Tracks active running total match victories for player one
  int _player2Score = 0; // Tracks active running total match victories for player two
  int _activePlayer = 1; // Directs turn states (1 tracks Player One operations, 2 targets Player Two sequences)
  String _arenaFeedback = "Player 1, fire a guess between 1 and 100!"; // Holds current versus prompt tracking context lines

  @override
  void initState() {
    super.initState();
    _resetArenaTarget(); // Generates a clean matching challenge base target right away
  }

  @override
  void dispose() {
    _versusController.dispose(); // Safely teardown the controller memory stream when exiting this context to prevent memory leaks
    super.dispose();
  }

  // --- ARENA RANDOM VALUE GENERATOR RULE ---
  void _resetArenaTarget() {
    _targetNumber = Random().nextInt(100) + 1; // Selects a random target range configuration strictly between 1 and 100
  }

  // --- COMPETITIVE MATCH TURN SYSTEM AND LOGIC CONTROLLER ---
  void _evaluateStrike() {
    final int? currentGuess = int.tryParse(_versusController.text);
    if (currentGuess == null) return; // Discard invalid or blank touch interactions immediately

    setState(() {
      if (currentGuess == _targetNumber) {
        // MATCH ROUND WINNER SELECTION AND METRIC INCREMENTATION
        if (_activePlayer == 1) {
          _player1Score++;
          _arenaFeedback = "🎯 Player 1 hits the mark! Direct strike (+1 Win)!";
        } else {
          _player2Score++;
          _arenaFeedback = "🎯 Player 2 hits the mark! Direct strike (+1 Win)!";
        }
        _resetArenaTarget(); // Generates a fresh secret target value instantly for the next round sequence
      } else {
        // MISSED TARGET: FORMULATE DIRECTION AND ALTERNATE TURNS
        final String direction = currentGuess < _targetNumber ? "Higher" : "Lower";
        
        if (_activePlayer == 1) {
          _activePlayer = 2; // Switches control states over to Player Two operations
          _arenaFeedback = "❌ Player 1 Missed! It's $direction. Player 2 is up!";
        } else {
          _activePlayer = 1; // Returns active control loops straight back to Player One configurations
          _arenaFeedback = "❌ Player 2 Missed! It's $direction. Player 1 is up!";
        }
      }
      _versusController.clear(); // Wipes typing blocks clean instantly upon execution submissions
    });
  }

  // --- REUSABLE SCOREGUARD COMPONENT GRID ELEMENT ---
  Widget _buildScoreCard(String player, int score, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16), // Balances interior typography vertical padding layout positions
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
            Text(
              player, // Draws player label identification names strings literal data
              style: const TextStyle(
                color: Colors.white60, // Mutes metadata headers to secondary focal priority
                fontSize: 12, // Small crisp caption scaling parameters
                fontWeight: FontWeight.bold, // Bolds name fields
                letterSpacing: 1.0, // Spreads tracking maps modernly
              ),
            ),
            const SizedBox(height: 8), // Interior cell stack layout clearance padding box
            Text(
              '$score WINS', // Prints structural scores variables output tracks
              style: TextStyle(
                color: color, // Highlights active score readouts matching assigned operational color context lines
                fontSize: 24, // Punchy readable scoring scale factor units
                fontWeight: FontWeight.w900, // Forces maximum visual density for critical scores parameters
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- MAIN VIEWPORT VISUAL ENGINE DRAW ROUTINES ---
  @override
  Widget build(BuildContext context) {
    // Dynamically tracks layouts highlight accents depending on which player controls the current active turn
    final Color activeTurnColor = _activePlayer == 1 ? GatorTheme.vividOrange : GatorTheme.versusBlue;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents Android window frame restructuring from dropping active keyboard streams
      body: Container(
        decoration: GatorTheme.screenGradientBackground, // Leverages the centralized global gradient design matrix block cleanly layout wide
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0), // Outer viewport bounding matrix alignment alignment
            child: Column(
              children: [
                const SizedBox(height: 20), // Top framing spatial clearance

                // --- HEADER NAV APP BAR ROW WRAPPER ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Locks navigation titles and close glyphs out onto outer alignment edges
                  children: [
                    Text(
                      'VERSUS ARENA', // View header title identification label string
                      style: TextStyle(
                        color: GatorTheme.versusBlue, // Colors the title text with your central versus mode blue token
                        fontSize: 20, // Clean dominant navigation font point rule
                        fontWeight: FontWeight.w900, // Matches bold style guidelines app-wide
                        letterSpacing: 1.5, // Sets slight technical spacing across tracking vectors
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 28), // RESTORED: Absolute X Close layout vector glyph asset
                      onPressed: () => Navigator.pop(context), // Pops navigation routes backward to drop users back into the main menu screen
                    ),
                  ],
                ),
                const SizedBox(height: 24), // Layout structural separation buffer row

                // --- COMPETITIVE MATCH SCOREBOARD INTERACTION HEADER ---
                Row(
                  children: [
                    _buildScoreCard('PLAYER 1', _player1Score, GatorTheme.vividOrange), // Draws player one scorecard painted in vibrant signature orange
                    const SizedBox(width: 16), // Gaps scorecard elements cleanly widthwise across the horizon grid
                    _buildScoreCard('PLAYER 2', _player2Score, GatorTheme.versusBlue), // Draws player two scorecard painted in high contrast versus blue
                  ],
                ),
                const Spacer(), // Centers gameplay text boxes elegantly across device viewports

                // --- SYSTEM ARENA DYNAMIC FEEDBACK TEXT ROW ---
                Text(
                  _arenaFeedback, // RESTORED: Direct live feed matching state alerts showing lower/higher or turn switches layout tags
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 32),

                // --- GLOWING ARENA ENTRY INTERACTION ZONE ---
                Container(
                  padding: const EdgeInsets.all(24), // Internal structural boundary container padding matrix
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GatorTheme.glassRadius), // Syncs container curvatures with the master theme blueprint
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.08), // Soft frosted glass layout filter plate
                        Colors.white.withValues(alpha: 0.02), // Trailing base backdrop transparency overlay
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15), // Locks crisp styling borders around active input frames
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: activeTurnColor.withValues(alpha: 0.06), // Dynamically changes glow color to track whichever player's turn is active
                        blurRadius: 30, // Spreads glow boundaries widely layout-wide
                        spreadRadius: 2, // Expands core aura structural parameters gently outwards
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'PLAYER $_activePlayer FIRING ZONE', // RESTORED: Dynamically flags exactly which user handles the hardware typing stream now
                        style: const TextStyle(
                          color: Colors.white70, // Slightly translucent white header layer tint
                          fontSize: 14, // Secondary body caption point dimension settings
                          fontWeight: FontWeight.bold, // Bolds helper label hierarchies
                          letterSpacing: 1.0, // Tracking spacing configuration rules
                        ),
                      ),
                      const SizedBox(height: 16), // Mid stack layout spacing spacer block
                      
                      // --- CORE TEXT FIELD INTERACTION ELEMENT ---
                      TextField(
                        controller: _versusController, // Binds the text editor stream receiver to capture layout input values
                        autofocus: true, // RESTORED: Commands system layouts to spawn soft keyboards instantly for ready touch sequences
                        keyboardType: TextInputType.number, // Restricts user hardware entries strictly to physical number layout grids
                        textAlign: TextAlign.center, // Keeps active typing streams positioned beautifully in dead layouts center
                        onSubmitted: (_) => _evaluateStrike(), // Fires calculations instantly upon system software enter execution clicks
                        style: TextStyle(
                          color: activeTurnColor, // Dynamically swaps typed character color tones depending on whose turn is running
                          fontSize: 32, // Giant readable numeric typing scale factor points
                          fontWeight: FontWeight.w900, // Forces heavy numeric presence on screens
                        ),
                        decoration: const InputDecoration(
                          hintText: '00', // Empty fallback baseline placement target configuration
                          hintStyle: TextStyle(color: Colors.white12), // Fades fallback placeholder indicators down out of focus scopes
                          border: InputBorder.none, // Strips away ugly raw platform text underline bounding frames
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24), // Dynamic layout spatial separation track

                // --- ACTION DISPATCH OPERATION TRIGGER ---
                SizedBox(
                  width: double.infinity, // Forces button element bounds to span margins entirely layout-wide
                  height: 56, // Sets premium professional structural touch height values
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: activeTurnColor, // Dynamically updates button colors to highlight whose turn it is to click launch
                    ),
                    onPressed: _evaluateStrike, // Maps standard gameplay calculations down onto target actions triggers
                    child: const Text('LAUNCH STRIKE'), // Action button structural display interaction label string text
                  ),
                ),
                const Spacer(), // Balancing elastic layout block to frame components neatly
              ],
            ),
          ),
        ),
      ),
    );
  }
}