// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle
import 'dart:math'; // Imports the math library to generate random secret numbers for gameplay
import '../theme/gator_theme.dart'; // References the master design system token profile file

// --- CUSTOM HISTORICAL DATA OBJECT TRACKER ---
class GuessAttempt {
  final int guess; // Stores the number the user submitted
  final String feedback; // Stores whether this specific number was too high or too low

  GuessAttempt({required this.guess, required this.feedback});
}

// --- SOLO CAMPAIGN GAMEPLAY CONTROLLER ---
class SoloGameScreen extends StatefulWidget {
  const SoloGameScreen({super.key}); // Configures the standard foundational constructor passing structural key trackers

  @override
  State<SoloGameScreen> createState() => _SoloGameScreenState(); // Instantiates the dynamic mutable state engine for this screen
}

class _SoloGameScreenState extends State<SoloGameScreen> {
  // --- STATE REGISTRATION FIELD TRACKERS ---
  final TextEditingController _guessController = TextEditingController(); // Allocates the memory stream to capture active text typing input
  final FocusNode _guessFocusNode = FocusNode(); // Allocates a persistent focus anchor to control device soft keyboard states
  late int _secretNumber; // Stores the target system-generated integer the user has to guess
  String _feedbackMessage = "I picked a number between 1 and 100. Good luck!"; // Holds the active live guidance text string shown to players
  final List<GuessAttempt> _history = []; // Registers the running sequential list of detailed player attempts and outcomes
  bool _isGameWon = false; // Tracks whether the user successfully hit the correct number target

  @override
  void initState() {
    super.initState(); // Executes standard parent initialization tasks first
    _startNewGame(); // Generates the game parameters right when the screen mounts
  }

  @override
  void dispose() {
    _guessController.dispose(); // Safely teardown the controller memory stream when exiting this context to prevent memory leaks
    _guessFocusNode.dispose(); // Safely teardown the focus management hardware links to clear memory footprints
    super.dispose();
  }

  // --- GAME RESET CORE INITIALIZATION LOGIC ---
  void _startNewGame() {
    final random = Random(); // Instantiates a standard random number generator engine instance
    _secretNumber = random.nextInt(100) + 1; // Pick a random integer boundary tracking strictly from 1 to 100 inclusive
    _feedbackMessage = "I picked a number between 1 and 100. Good luck!"; // Restores initial text guidance layout message fields
    _history.clear(); // Wipes the user's recent attempt history tracking clean for the new match round
    _isGameWon = false; // Restores winning flag tracking to false so interactive cycles reopen
    _guessFocusNode.requestFocus(); // Asserts hardware control loops to pop the system keyboard open immediately on new games
  }

  // --- CORE GAME METRICS CALCULATOR LOGIC ---
  void _processGuess() {
    if (_isGameWon) return; // Completely shield data tracks from editing if game states are already completed

    final int? currentGuess = int.tryParse(_guessController.text); // Parses typed user string content safely into an interactive integer format
    
    if (currentGuess == null) return; // Completely abort processing tracking streams if the field input is invalid or blank

    setState(() {
      String specificFeedback; // Holds the specific outcome flag for this exact guess
      
      if (currentGuess == _secretNumber) {
        _isGameWon = true; // Sets win flag tracker immediately to block layout input methods
        _guessFocusNode.unfocus(); // Drops soft device keyboard down out of focus since active guessing loops closed
        specificFeedback = "Correct! 🎉"; // Win tracking baseline indicator string
        _feedbackMessage = "🎉 Correct! You got it in ${_history.length + 1} tries!"; // Win state messaging injection
      } else if (currentGuess < _secretNumber) {
        specificFeedback = "Too Low 📉"; // Low directional metric string assignment
        _feedbackMessage = "📉 Higher! Try a bigger number."; // Low state guidance tracking injection
      } else {
        specificFeedback = "Too High 📈"; // High directional metric string assignment
        _feedbackMessage = "📈 Lower! Try a smaller number."; // High state guidance tracking injection
      }

      // Logs the guess alongside its directional label right to the historical list feed
      _history.insert(0, GuessAttempt(guess: currentGuess, feedback: specificFeedback));
      
      _guessController.clear(); // Flushes the active interaction input field clean for the user's next shot
      
      if (!_isGameWon) {
        _guessFocusNode.requestFocus(); // Only demands keyboard focus back if games remain active
      }
    });
  }

  // --- REUSABLE GLASSMORPHIC HISTORY LIST ROW BUILDER ---
  Widget _buildHistoryRow(GuessAttempt attempt) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6), // Gaps out historical items cleanly across vertical list paths
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Internal cell cushion spacing parameters
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GatorTheme.glassRadius), // Ties list containers cleanly to your master glass curve token
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.08), // Frosted glass layout plate tracking matching visual depths
            Colors.white.withValues(alpha: 0.02), // Fades out the base layer nicely
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12), // Crisp structural perimeter border stroke lines
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Shoots numbers to the left margin and feedback labels cleanly to the right
        children: [
          Text(
            'Guessed: ${attempt.guess}', // Renders the exact input number submitted by users
            style: const TextStyle(
              color: Colors.white, // Paints text strings solid white layout-wide
              fontSize: 16, // Highly scannable list item font metric scaling
              fontWeight: FontWeight.bold, // Structural taxonomy bold mappings
            ),
          ),
          Text(
            attempt.feedback, // Displays whether this exact submission was too high or too low
            style: TextStyle(
              color: attempt.feedback.contains('Correct') ? Colors.greenAccent : GatorTheme.vividOrange, // Highlights correct guesses in green and hints in vivid orange
              fontSize: 15, // Clear secondary description scaling parameter rules
              fontWeight: FontWeight.w600, // Semi-bold configuration weight metrics
            ),
          ),
        ],
      ),
    );
  }

  // --- MAIN VIEWPORT VISUAL ENGINE DRAW ROUTINES ---
  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes app title and exit markers out to maximum layout boundaries
                  children: [
                    const Text(
                      'SOLO CAMPAIGN', // View header title identification label string
                      style: TextStyle(
                        color: Colors.white, // Colors header context solid bright white
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
                const SizedBox(height: 30), // Structural spatial separation row buffer

                // --- SYSTEM STATE DYNAMIC FEEDBACK BANNER TEXT ---
                Text(
                  _feedbackMessage, // Live dynamic text layout tracking higher, lower, and pick instructions variables
                  textAlign: TextAlign.center, // Dead centers instructional layouts across running phone screen viewports
                  style: const TextStyle(
                    color: Colors.white, // Pure clean white for ultimate layout legibility
                    fontSize: 18, // Clean mid-tier readable presentation font size tracking point
                    fontWeight: FontWeight.w600, // Alignment block weighting configuration
                  ),
                ),
                const SizedBox(height: 24), // Layout structural separation track

                // --- GLOWING INPUT CONTROLLER ENVELOPE ---
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
                        color: _isGameWon ? Colors.greenAccent.withValues(alpha: 0.08) : GatorTheme.vividOrange.withValues(alpha: 0.08), // Flips shadow ambiance to green upon win
                        blurRadius: 30, // Spreads glow boundaries widely layout-wide
                        spreadRadius: 2, // Expands core aura structural parameters gently outwards
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _isGameWon ? 'MATCH COMPLETE' : 'ENTER YOUR GUESS', // Toggles context labels header cleanly
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
                        controller: _guessController, // Binds the text editor stream receiver to capture layout input values
                        focusNode: _guessFocusNode, // Connects our specific focus hook state to maintain uninterrupted keyboard access
                        enabled: !_isGameWon, // BLOCKS GUESSING: Shuts off text interactions fields fully once players win matches
                        keyboardType: TextInputType.number, // Restricts user hardware entries strictly to physical number layout grids
                        textAlign: TextAlign.center, // Keeps active typing streams positioned beautifully in dead layouts center
                        onSubmitted: (_) => _processGuess(), // Processes calculations instantly if users tap execution actions directly on system keyboards
                        style: TextStyle(
                          color: _isGameWon ? Colors.greenAccent : GatorTheme.vividOrange, // Morph colors instantly to celebrate winning completions
                          fontSize: 32, // Giant readable numeric typing scale factor points
                          fontWeight: FontWeight.w900, // Forces heavy numeric presence on screens
                        ),
                        decoration: InputDecoration(
                          hintText: _isGameWon ? '🏆' : '00', // Replaces template targets with trophy glyph elements when won
                          hintStyle: const TextStyle(color: Colors.white12), // Fades fallback placeholder indicators down out of focus scopes
                          border: InputBorder.none, // Strips away ugly raw platform text underline bounding frames
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Dynamic layout spatial separation track

                // --- SYSTEM ACTION TRIGGER OPERATION COMMAND ---
                SizedBox(
                  width: double.infinity, // Forces button element bounds to span margins entirely layout-wide
                  height: 54, // Sets premium professional structural touch height values
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isGameWon ? Colors.greenAccent : GatorTheme.vividOrange, // Updates color configurations layout-wide when won
                      foregroundColor: _isGameWon ? Colors.black87 : Colors.white, // Shifts button text to dark gray on green backdrop for slick contrast
                    ),
                    onPressed: _isGameWon ? _startNewGame : _processGuess, // PLAY AGAIN ASSIGNMENT: Toggles button actions logic instantly depending on game status
                    child: Text(_isGameWon ? 'PLAY AGAIN' : 'SUBMIT GUESS'), // Toggles character print instructions cleanly on buttons view fields
                  ),
                ),
                const SizedBox(height: 28), // Spatial allocation block above structural lists fields

                // --- HIGH-VISIBILITY HISTORY SECTION FEED ---
                if (_history.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Left aligns lower scrolling track text fields
                      children: [
                        const Text(
                          'RECENT ATTEMPTS LOG', // Historical list feed category label text header
                          style: TextStyle(
                            color: Colors.white38, // Heavily muted label style configuration
                            fontSize: 11, // Small functional metadata scaling rules
                            fontWeight: FontWeight.bold, // Structural taxonomy bold mappings
                            letterSpacing: 1.2, // Clean modern font tracking adjustments
                          ),
                        ),
                        const SizedBox(height: 8), // Tiny visual spacing gap below list title header
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero, // Removes default framing padding calculations completely
                            itemCount: _history.length, // Syncs count loops directly to tracking list dimensions
                            itemBuilder: (context, index) => _buildHistoryRow(_history[index]), // Spits out your high-vis item row element
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const Spacer(), // Keeps component balances centered perfectly on screens if list logs remain empty
              ],
            ),
          ),
        ),
      ),
    );
  }
}