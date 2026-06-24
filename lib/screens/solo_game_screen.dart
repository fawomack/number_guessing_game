// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'dart:math'; // Imports Dart's mathematical utility engine to secure true pseudo-randomization functions
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle
import '../theme/gator_theme.dart'; // References the master design system token profile file

// --- CUSTOM HISTORICAL DATA OBJECT TRACKER ---
class SoloAttempt {
  final int guess; // Stores the specific number submitted by the player
  final String direction; // Stores text mapping: "Too High ↑" or "Too Low ↓"
  final Color alertColor; // Holds the explicit color token for visual feedback formatting

  SoloAttempt({
    required this.guess,
    required this.direction,
    required this.alertColor,
  });
}

// --- SOLO COMPETITIVE ARENA GAMEPLAY CONTROLLER ---
class SoloGameScreen extends StatefulWidget {
  const SoloGameScreen({super.key}); // Configures standard foundational class constructor tracking references

  @override
  State<SoloGameScreen> createState() => _SoloGameScreenState(); // Instantiates mutable runtime state loops
}

class _SoloGameScreenState extends State<SoloGameScreen> {
  // --- STATE REGISTRATION FIELD TRACKERS ---
  final TextEditingController _soloController = TextEditingController(); // Allocates input typing character streaming buffers
  final FocusNode _soloFocusNode = FocusNode(); // Binds system soft keyboard visibility configurations
  final Random _randomEngine = Random(); // Instantiates a dedicated, robust random state generation machine
  
  late int _secretTargetNumber; // Holds the active hidden code targeted for guess tracking loops
  int _soloScore = 0; // Tracks master cumulative game round victories
  
  String _gameStatusFeedback = "Enter a guess between 1 and 100 to begin!"; // Core operational guidance presentation string
  Color _feedbackDisplayColor = Colors.white; // Controls core status font coloring profiles
  final List<SoloAttempt> _matchHistoryLog = []; // Tracks scrolling array lists parameters for runtime guesses
  bool _isRoundComplete = false; // Flag status locking inputs when the round ends successfully

  @override
  void initState() {
    super.initState(); // Dispatches parent initializer functions first
    _generateRandomArenaTarget(); // Generates baseline secret codes on step one parameters
    _soloFocusNode.requestFocus(); // Force soft hardware typing layouts open instantly
  }

  @override
  void dispose() {
    _soloController.dispose(); // Destroys streaming text references cleanly to secure memory footprints
    _soloFocusNode.dispose(); // Unlinks focus nodes hooks safely away from hardware engines
    super.dispose();
  }

  // --- ARENA RANDOM TARGET GENERATION MATRIX ---
  void _generateRandomArenaTarget() {
    // Generates a hidden target integer uniformly distributed between 1 and 100 inclusive using the dedicated random utility
    _secretTargetNumber = _randomEngine.nextInt(100) + 1;
  }

  // --- HARD GAME STATE INITIALIZATION RESET ---
  void _resetSoloMatchCycle() {
    setState(() {
      _generateRandomArenaTarget(); // Injects a fresh randomized secret integer map
      _isRoundComplete = false; // Opens standard text processing gate parameters
      _matchHistoryLog.clear(); // Wipes item arrays clean for current logging tracks
      _soloController.clear(); // Flushes string entries completely out of interaction blocks
      _feedbackDisplayColor = Colors.white; // Resets central prompt color to basic neutral
      _gameStatusFeedback = "New secret number set! Enter a guess (1-100):"; // Setup guidelines message restored to standard terms
      
      // Delays the focus cycle by one frame to let the framework build engine cycle through layout loops cleanly
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _soloFocusNode.requestFocus();
      });
    });
  }

  // --- CORE GAME LOGIC EVALUATION ENGINE ---
  void _evaluatePlayerGuessSubmission() {
    if (_isRoundComplete) {
      _resetSoloMatchCycle(); // Route commands out directly to system re-initializers if rounds match completed criteria
      return;
    }

    final int? playerInputData = int.tryParse(_soloController.text); // Parses typed string metrics safely into integer types
    
    // Validate entry inputs sit flawlessly within operational boundary targets
    if (playerInputData == null || playerInputData < 1 || playerInputData > 100) {
      setState(() {
        _gameStatusFeedback = "⚠️ Invalid! Please enter a number between 1 and 100."; // Direct instructional error notice
        _feedbackDisplayColor = Colors.amberAccent; // Flash warning notice tint maps onto the text field
      });
      return;
    }

    setState(() {
      if (playerInputData == _secretTargetNumber) {
        // TARGET CRACKED DIRECT HIT DETECTED
        _isRoundComplete = true; 
        _soloScore++; // Increments standard round win score
        _soloFocusNode.unfocus(); // Drops soft keyboard away cleanly to expand visibility maps
        
        _feedbackDisplayColor = Colors.greenAccent; // Target color: Emerald green for victory confirmation
        _gameStatusFeedback = "🎯 Correct! You guessed the secret number: $_secretTargetNumber!";
        
        // Logs the definitive win attempt cleanly into our rolling view history stack
        _matchHistoryLog.insert(0, SoloAttempt(
          guess: playerInputData,
          direction: "Correct! 🎯",
          alertColor: Colors.greenAccent,
        ));
      } else {
        // MISSED TARGET FORMATTING TESTS: REPLACING EMOJIS WITH DIRECTIONAL TINTS
        final bool isTooLow = playerInputData < _secretTargetNumber;
        
        // COLOR FORMAT EXPERIMENT: Blue for low drops, Orange for high heights (No confusing graphic emojis)
        final Color contextFormattingColor = isTooLow ? GatorTheme.versusBlue : GatorTheme.vividOrange;
        final String formattedDirectionText = isTooLow ? "Too Low ↑" : "Too High ↓";

        _feedbackDisplayColor = contextFormattingColor; // Colors the central main feedback text line dynamically
        _gameStatusFeedback = "Guess was $formattedDirectionText";

        // Locks explicit visual tint references directly into specific index logs for list item borders
        _matchHistoryLog.insert(0, SoloAttempt(
          guess: playerInputData,
          direction: formattedDirectionText,
          alertColor: contextFormattingColor, 
        ));

        _soloController.clear(); // Empty typing zone ready for instant re-entry sequence
        
        // Force text field target node bindings to remain locked open using framework frame delay trackers
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _soloFocusNode.requestFocus();
        });
      }
    });
  }

  // --- REUSABLE GLASSMORPHIC HISTORY ROW COMPONENT ---
  Widget _buildSoloHistoryRow(SoloAttempt logItem) {
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
          color: logItem.alertColor.withValues(alpha: 0.25), // Uses the experimental explicit alert color token for cell framing
          width: 1.2, // Continuous hairline border thickness tracking
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes match tracking indices to opposite poles cleanly across the horizon axis
        children: [
          // --- GUESS VALUE PRINT ELEMENT ---
          Text(
            'You guessed: ${logItem.guess}',
            style: const TextStyle(
              color: Colors.white, // Solid bright white layout-wide font characters sets
              fontSize: 15, // Scannable high visibility list dimensions points
              fontWeight: FontWeight.bold, // Bold emphasis weight mapping rules
            ),
          ),

          // --- COLOR CODED TEXT DICTIONARY ELEMENT ---
          Text(
            logItem.direction,
            style: TextStyle(
              color: logItem.alertColor, // Applies experimental explicit target colors directly onto directional label outputs
              fontSize: 15, // Matching scannable layout sizes
              fontWeight: FontWeight.bold, // Structural taxonomy bold mappings
              letterSpacing: 0.5, // Crisp font width spacing adjustments
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
        decoration: GatorTheme.screenGradientBackground, // Anchors standardized custom background canvas layout maps app-wide
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
                      'SOLO MODE', // Restored clean, original title terminology profile
                      style: TextStyle(
                        color: GatorTheme.vividOrange, // Distinct solo mode identifier color token
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

                // --- RUNNING SCORE DISPLAY CARD ---
                Container(
                  width: double.infinity, // Forces score widget bounds to span margins entirely layout-wide
                  padding: const EdgeInsets.symmetric(vertical: 16), // Vertical interior structural boundaries cushion lines
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GatorTheme.glassRadius), // Syncs container curvatures with the master theme blueprint
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.08), // Soft frosted glass layout filter plate
                        Colors.white.withValues(alpha: 0.02), // Trailing base backdrop transparency overlay
                      ],
                    ),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1.0), // Locks crisp styling borders around active frames
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'CURRENT SCORE', // Cleaned wording text indicator
                        style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                      ),
                      const SizedBox(height: 4), // Interior stack alignment buffer gap
                      Text(
                        '$_soloScore WINS', // Display cumulative player round score parameters safely
                        style: TextStyle(color: GatorTheme.vividOrange, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1.0),
                      ),
                    ],
                  ),
                ),
                const Spacer(), // Centers gameplay text boxes elegantly across device viewports

                // --- SYSTEM ARENA DYNAMIC FEEDBACK TEXT ROW ---
                Text(
                  _gameStatusFeedback, // Direct live feed tracking showing experimental directional text configurations
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _feedbackDisplayColor, // Dynamically updates text color to explicitly match experimental directional tints
                    fontSize: 17, // Mid-tier highly readable presentation points
                    fontWeight: FontWeight.w700, // Heavy configuration profile parameters
                  ),
                ),
                const SizedBox(height: 32), // Layout separation block tracking height dimensions

                // --- GLOWING ARENA ENTRY INTERACTION ZONE ---
                Container(
                  padding: const EdgeInsets.all(24), // Internal structural boundary container padding matrix
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GatorTheme.glassRadius), // Connects elements cleanly to our master glass curve token
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.08), // Glazes base layers with thin transparency maps
                        Colors.white.withValues(alpha: 0.02), // Fades bottom plate boundaries softly out of view fields
                      ],
                    ),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.15)), // Locks crisp styling borders around active input frames
                    boxShadow: [
                      BoxShadow(
                        color: _feedbackDisplayColor.withValues(alpha: 0.06), // Dynamically shadows text zone frames using experimental alert feedback tones
                        blurRadius: 30, // Spreads glow boundaries widely layout-wide
                        spreadRadius: 2, // Expands core aura structural parameters gently outwards
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _isRoundComplete ? 'ROUND OVER' : 'ENTER YOUR GUESS', // Restored simple layout text strings
                        style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                      ),
                      const SizedBox(height: 8), // Interior block alignment buffer gap
                      
                      // --- CORE TEXT FIELD INTERACTION ELEMENT ---
                      TextField(
                        controller: _soloController, // Binds the text editor stream receiver to capture layout input values
                        focusNode: _soloFocusNode, // Connects our specific focus hook state to maintain uninterrupted keyboard access
                        enabled: !_isRoundComplete, // BLOCKS INTERACTION: Shuts off active typing paths fully once the round ends
                        keyboardType: TextInputType.number, // Restricts user hardware entries strictly to physical number layout grids
                        textAlign: TextAlign.center, // Keeps active typing streams positioned beautifully in dead layouts center
                        onSubmitted: (_) => _evaluatePlayerGuessSubmission(), // Routes execution triggers automatically through selection parsing engines
                        style: TextStyle(
                          color: _isRoundComplete ? Colors.greenAccent : GatorTheme.vividOrange, // Swaps numeric text colors matching states
                          fontSize: 34, // Giant readable numeric typing scale factor points
                          fontWeight: FontWeight.w900, // Forces heavy numeric presence on screens
                        ),
                        decoration: InputDecoration(
                          hintText: _isRoundComplete ? '🎯' : '00', // Morph baseline target targets cleanly matching operations maps
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
                      backgroundColor: _isRoundComplete ? Colors.greenAccent : GatorTheme.vividOrange, // Dynamically maps button fills matching states
                      foregroundColor: _isRoundComplete ? Colors.black87 : Colors.white, // Shifts character tone coloring profiles for contrast
                    ),
                    onPressed: _evaluatePlayerGuessSubmission, // Dispatches commands cleanly directly to our master action evaluation engine
                    child: Text(_isRoundComplete ? 'PLAY AGAIN' : 'SUBMIT GUESS'), // Restored clean standard action text terminology
                  ),
                ),
                const SizedBox(height: 28), // Spatial allocation block above structural lists fields

                // --- HIGH-VISIBILITY HISTORY SECTION FEED ---
                if (_matchHistoryLog.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'GUESS HISTORY', // Restored clean simple history list title header label string
                          style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                        const SizedBox(height: 8), // Tiny visual spacing gap below list title header
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero, // Eliminates base margin list processing defaults out cleanly
                            itemCount: _matchHistoryLog.length, // Locks dynamic loop indices bounds directly onto history counts
                            itemBuilder: (context, index) => _buildSoloHistoryRow(_matchHistoryLog[index]), // Spits out custom track cards rows
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