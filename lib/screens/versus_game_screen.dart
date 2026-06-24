// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle
import 'dart:math'; // Imports the math engine bundle to capture random range generations
import '../theme/gator_theme.dart'; // References the master design system token profile file

// --- CUSTOM HISTORICAL DATA OBJECT TRACKER ---
class VersusAttempt {
  final int player; // Tracks which user made the shot (1 or 2)
  final int guess; // Stores the specific number submitted
  final String feedback; // Stores directional hints like "Too High" or "Too Low"
  final Color playerColor; // Caches the contextual player accent color map for clean item row rendering

  VersusAttempt({
    required this.player,
    required this.guess,
    required this.feedback,
    required this.playerColor,
  });
}

// --- VERSUS COMPETITIVE ARENA GAMEPLAY CONTROLLER ---
class VersusGameScreen extends StatefulWidget {
  const VersusGameScreen({super.key}); // Configures the standard foundational constructor passing structural key trackers

  @override
  State<VersusGameScreen> createState() => _VersusGameScreenState(); // Instantiates the dynamic mutable state engine for this screen
}

class _VersusGameScreenState extends State<VersusGameScreen> {
  // --- STATE REGISTRATION FIELD TRACKERS ---
  final TextEditingController _versusController = TextEditingController(); // Allocates the memory stream to capture competitive player entry text
  final FocusNode _versusFocusNode = FocusNode(); // Allocates a persistent focus anchor to control device soft keyboard states
  late int _targetNumber; // The secret target value generated for the ongoing interactive turn
  int _player1Score = 0; // Tracks active running total match victories for player one
  int _player2Score = 0; // Tracks active running total match victories for player two
  int _activePlayer = 1; // Directs turn states (1 tracks Player One operations, 2 targets Player Two sequences)
  String _arenaFeedback = "Player 1, fire a guess between 1 and 100!"; // Holds current versus prompt tracking context lines
  final List<VersusAttempt> _arenaHistory = []; // Registers the running sequential history log of all competitive attempts and missed targets
  bool _isRoundOver = false; // Tracks whether the current target value has been cracked successfully

  @override
  void initState() {
    super.initState();
    _resetArenaTarget(); // Generates a clean matching challenge base target right away
  }

  @override
  void dispose() {
    _versusController.dispose(); // Safely teardown the controller memory stream when exiting this context to prevent memory leaks
    _versusFocusNode.dispose(); // Safely teardown the focus management hardware links to clear memory footprints
    super.dispose();
  }

  // --- ARENA RANDOM VALUE GENERATOR RULE ---
  void _resetArenaTarget() {
    _targetNumber = Random().nextInt(100) + 1; // Selects a random target range configuration strictly between 1 and 100
    _arenaFeedback = "Player $_activePlayer, fire a guess between 1 and 100!"; // Builds contextual dynamic turn instructional strings
    _arenaHistory.clear(); // Flushes previous attempts records cleanly out of active view layouts
    _isRoundOver = false; // Opens up input parameters safely for active interactions
    _versusFocusNode.requestFocus(); // Demands immediate hardware soft keyboard focus on reset cycles
  }

  // --- COMPETITIVE MATCH TURN SYSTEM AND LOGIC CONTROLLER ---
  void _evaluateStrike() {
    if (_isRoundOver) return; // Completely shield data tracks from editing if target matches are completed

    final int? currentGuess = int.tryParse(_versusController.text);
    if (currentGuess == null) return; // Discard invalid or blank touch interactions immediately

    final Color currentTurnColor = _activePlayer == 1 ? GatorTheme.vividOrange : GatorTheme.versusBlue;

    setState(() {
      if (currentGuess == _targetNumber) {
        // MATCH ROUND WINNER SELECTION AND METRIC INCREMENTATION
        _isRoundOver = true; // Flips round states flag to freeze text interfaces instantly
        _versusFocusNode.unfocus(); // Drops keyboards away cleanly upon direct strikes completions
        
        if (_activePlayer == 1) {
          _player1Score++;
          _arenaFeedback = "🎯 Player 1 hits the mark! Direct strike (+1 Win)!";
        } else {
          _player2Score++;
          _arenaFeedback = "🎯 Player 2 hits the mark! Direct strike (+1 Win)!";
        }

        _arenaHistory.insert(0, VersusAttempt(
          player: _activePlayer,
          guess: currentGuess,
          feedback: "Direct Hit! 🎯",
          playerColor: Colors.greenAccent,
        ));
      } else {
        // MISSED TARGET: FORMULATE DIRECTION AND ALTERNATE TURNS
        final String direction = currentGuess < _targetNumber ? "Too Low 📉" : "Too High 📈";
        
        _arenaHistory.insert(0, VersusAttempt(
          player: _activePlayer,
          guess: currentGuess,
          feedback: direction,
          playerColor: currentTurnColor,
        ));

        if (_activePlayer == 1) {
          _activePlayer = 2; // Switches control states over to Player Two operations
          _arenaFeedback = "❌ Player 1 Missed! It's ${direction.split(' ')[0]}. Player 2 is up!";
        } else {
          _activePlayer = 1; // Returns active control loops straight back to Player One configurations
          _arenaFeedback = "❌ Player 2 Missed! It's ${direction.split(' ')[0]}. Player 1 is up!";
        }
      }
      
      _versusController.clear(); // Wipes typing blocks clean instantly upon execution submissions
      
      if (!_isRoundOver) {
        _versusFocusNode.requestFocus(); // Maintains continuous keyboard focus for seamless play turnovers
      }
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

  // --- REUSABLE GLASSMORPHIC ARENA HISTORY ROW BUILDER ---
  Widget _buildArenaHistoryRow(VersusAttempt attempt) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6), // Gaps out vertical items log cells
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Internal tracking lists cell borders cushion lines
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GatorTheme.glassRadius), // Clips container fields inside master curve values
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.06), // Subtle frosting overlays profile records maps
            Colors.white.withValues(alpha: 0.02), // Transparent base values boundaries
          ],
        ),
        border: Border.all(
          color: attempt.playerColor.withValues(alpha: 0.2), // Tints historical item cells boundaries match player identity assets
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes match tracking indices to opposite poles cleanly
        children: [
          Row(
            children: [
              Container(
                width: 8, // Tiny indicator dot element metric thickness layout parameters
                height: 8,
                decoration: BoxDecoration(
                  color: attempt.playerColor, // Paints indicator bulbs with active context color maps
                  shape: BoxShape.circle, // Curves helper icons to clean circles arrays
                ),
              ),
              const SizedBox(width: 12), // Horizontal clearance spacing spacer bounds
              Text(
                'P${attempt.player} fired: ${attempt.guess}', // Renders whose turn hit this index number parameter
                style: const TextStyle(
                  color: Colors.white, // Solid bright white layout-wide font characters sets
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            attempt.feedback, // Displays dynamic too high, too low, or hit alerts tags
            style: TextStyle(
              color: attempt.feedback.contains('Hit') ? Colors.greenAccent : Colors.white60, // Lights wins green and keeps missed hints soft silver gray
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // --- MAIN VIEWPORT VISUAL ENGINE DRAW ROUTINES ---
  @override
  Widget build(BuildContext context) {
    // Dynamically tracks layouts highlight accents depending on which player controls the current active turn
    final Color activeTurnColor = _isRoundOver ? Colors.greenAccent : (_activePlayer == 1 ? GatorTheme.vividOrange : GatorTheme.versusBlue);

    return Scaffold(
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
                      icon: const Icon(Icons.close, color: Colors.white, size: 28), // Absolute X Close layout vector glyph asset
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
                  _arenaFeedback, // Direct live feed matching state alerts showing lower/higher or turn switches layout tags
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
                        _isRoundOver ? 'ARENA SECURED' : 'PLAYER $_activePlayer FIRING ZONE', // Dynamically flags exactly who handles the hardware typing stream now
                        style: const TextStyle(
                          color: Colors.white70, // Slightly translucent white header layer tint
                          fontSize: 14, // Secondary body caption point dimension settings
                          fontWeight: FontWeight.bold, // Bolds helper label hierarchies
                          letterSpacing: 1.0, // Tracking spacing configuration rules
                        ),
                      ),
                      const SizedBox(height: 8), // Mid stack layout spacing spacer block
                      
                      // --- CORE TEXT FIELD INTERACTION ELEMENT ---
                      TextField(
                        controller: _versusController, // Binds the text editor stream receiver to capture layout input values
                        focusNode: _versusFocusNode, // Connects our specific focus hook state to maintain uninterrupted keyboard access
                        enabled: !_isRoundOver, // BLOCKS INTERACTION: Shuts off active typing paths fully once rounds end
                        keyboardType: TextInputType.number, // Restricts user hardware entries strictly to physical number layout grids
                        textAlign: TextAlign.center, // Keeps active typing streams positioned beautifully in dead layouts center
                        onSubmitted: (_) => _evaluateStrike(), // Fires calculations instantly upon system software enter execution clicks
                        style: TextStyle(
                          color: activeTurnColor, // Dynamically swaps typed character color tones depending on whose turn is running
                          fontSize: 32, // Giant readable numeric typing scale factor points
                          fontWeight: FontWeight.w900, // Forces heavy numeric presence on screens
                        ),
                        decoration: InputDecoration(
                          hintText: _isRoundOver ? '🏆' : '00', // Replaces placeholders with win icons context sets once targets break
                          hintStyle: const TextStyle(color: Colors.white12), // Fades fallback placeholder indicators down out of focus scopes
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
                      foregroundColor: _isRoundOver ? Colors.black87 : Colors.white, // Inverts label styling shades on round wins for visibility setup
                    ),
                    onPressed: _isRoundOver ? _resetArenaTarget : _evaluateStrike, // PLAY AGAIN RE-BINDING: Switches logic targets depending on match round status
                    child: Text(_isRoundOver ? 'PLAY AGAIN' : 'LAUNCH STRIKE'), // Action button structural display interaction label string text
                  ),
                ),
                const SizedBox(height: 28), // Spacer separation index block row height rules

                // --- HIGH-VISIBILITY HISTORY SECTION FEED ---
                if (_arenaHistory.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ARENA TRACK REGISTRY LOG', // Competitive live registry category label tag string
                          style: TextStyle(
                            color: Colors.white38, // Faded taxonomic label color parameters
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero, // Eliminates base margin list processing defaults out cleanly
                            itemCount: _arenaHistory.length, // Locks dynamic loop indices bounds directly onto history counts
                            itemBuilder: (context, index) => _buildArenaHistoryRow(_arenaHistory[index]), // Spits out custom competitive track cards rows
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const Spacer(), // Balance components evenly across display centers if no history rows exist yet
              ],
            ),
          ),
        ),
      ),
    );
  }
}