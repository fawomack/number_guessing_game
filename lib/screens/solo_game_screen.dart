// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle
import '../theme/gator_theme.dart'; // References the master design system token profile file

// --- CUSTOM HISTORICAL DATA OBJECT TRACKER ---
class SoloAttempt {
  final int guess; // Stores the specific number submitted by the player
  final String direction; // Stores text mapping: "Too High" or "Too Low"
  final Color alertColor; // Experimental: Holds the explicit color token for visual feedback formatting

  SoloAttempt({
    required this.guess,
    required this.direction,
    required this.alertColor,
  });
}

// --- SOLO ADAPTIVE TRAINING ARENA SYSTEM CONTROLLER ---
class SoloGameScreen extends StatefulWidget {
  const SoloGameScreen({super.key}); // Configures standard foundational class constructor tracking references

  @override
  State<SoloGameScreen> createState() => _SoloGameScreenState(); // Instantiates mutable runtime state loops
}

class _SoloGameScreenState extends State<SoloGameScreen> {
  // --- STATE REGISTRATION FIELD TRACKERS ---
  final TextEditingController _soloController = TextEditingController(); // Allocates input typing character streaming buffers
  final FocusNode _soloFocusNode = FocusNode(); // Binds system soft keyboard visibility configurations
  
  late int _secretTargetNumber; // Holds the active hidden code targeted for computational crack cycles
  int _scoreStrikeWins = 0; // Tracks running multi-round session direct hit win scores
  
  String _gameStatusFeedback = "Enter a tactical guess between 1 and 100 to begin!"; // Core operational guidance presentation string
  Color _feedbackDisplayColor = Colors.white; // Experimental: Controls core status font coloring profiles
  final List<SoloAttempt> _matchHistoryLog = []; // Tracks scrolling array lists parameters for runtime guesses
  bool _isRoundComplete = false; // Flag status locking inputs when codes drop successfully

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
    // Generates a hidden target integer uniformly distributed between 1 and 100 inclusive
    _secretTargetNumber = (DateTime.now().microsecondsSinceEpoch % 100) + 1;
  }

  // --- HARD GAME STATE INITIALIZATION RESET ---
  void _resetSoloMatchCycle() {
    setState(() {
      _generateRandomArenaTarget(); // Injects a fresh randomized secret integer map
      _isRoundComplete = false; // Opens standard text processing gate parameters
      _matchHistoryLog.clear(); // Wipes item arrays clean for current logging tracks
      _soloController.clear(); // Flushes string entries completely out of interaction blocks
      _feedbackDisplayColor = Colors.white; // Resets central prompt color to basic neutral
      _gameStatusFeedback = "Fresh target locked in! Enter a guess (1-100):"; // Setup guidelines message
      
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
        _gameStatusFeedback = "⚠️ Selection invalid! Enter numbers strictly from 1 to 100.";
        _feedbackDisplayColor = Colors.amberAccent; // Flash alert notice tint maps
      });
      return;
    }

    setState(() {
      if (playerInputData == _secretTargetNumber) {
        // TARGET CRACKED DIRECT HIT DETECTED
        _isRoundComplete = true; 
        _scoreStrikeWins++; // Increments session points matrices
        _soloFocusNode.unfocus(); // Drops soft keyboard away cleanly to expand visibility maps
        
        _feedbackDisplayColor = Colors.greenAccent; // Target color: Emerald green for victory confirmation
        _gameStatusFeedback = "🎯 Target Eliminated! Clean strike on number $_secretTargetNumber!";
        
        _matchHistoryLog.insert(0, SoloAttempt(
          guess: playerInputData,
          direction: "MATCH SECURED",
          alertColor: Colors.greenAccent,
        ));
      } else {
        // MISSED TARGET FORMATTING TESTS: REPLACING EMOJIS WITH DIRECTIONAL TINTS
        final bool isTooLow = playerInputData < _secretTargetNumber;
        
        // EXPERIMENTAL FORMAT: Blue for low drops, Orange for high heights (No confusing graphic emojis)
        final Color contextFormattingColor = isTooLow ? GatorTheme.versusBlue : GatorTheme.vividOrange;
        final String formattedDirectionText = isTooLow ? "Too Low ↑" : "Too High ↓";

        _feedbackDisplayColor = contextFormattingColor; // Colors the central main feedback text line dynamically
        _gameStatusFeedback = "Missed! Your guess was $formattedDirectionText";

        _matchHistoryLog.insert(0, SoloAttempt(
          guess: playerInputData,
          direction: formattedDirectionText,
          alertColor: contextFormattingColor, // Locks explicit visual tint references directly into specific index logs
        ));

        _soloController.clear(); // Empty typing zone ready for instant re-entry sequence
        
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _soloFocusNode.requestFocus();
        });
      }
    });
  }

  // --- REUSABLE GLASSMORPHIC HISTORY ROW COMPONENT ---
  Widget _buildSoloHistoryRow(SoloAttempt logItem) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(GatorTheme.glassRadius),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.06),
            Colors.white.withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(
          color: logItem.alertColor.withValues(alpha: 0.25), // Uses the experimental explicit alert color token for cell framing
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'You guessed: ${logItem.guess}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            logItem.direction,
            style: TextStyle(
              color: logItem.alertColor, // Applies experimental explicit target colors directly onto directional label outputs
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
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
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // --- HEADER NAV APP BAR ROW WRAPPER ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SOLO TRAINING',
                      style: TextStyle(
                        color: GatorTheme.vividOrange, // Distinct solo mode identifier color token
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- MONOLITHIC RUNNING WIN RECORD DISPLAY CARD ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GatorTheme.glassRadius),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.02),
                      ],
                    ),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'CURRENT TRAINING STRIKE SCORE',
                        style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_scoreStrikeWins ELIMINATIONS',
                        style: TextStyle(color: GatorTheme.vividOrange, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1.0),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                // --- SYSTEM ARENA DYNAMIC FEEDBACK TEXT ROW ---
                Text(
                  _gameStatusFeedback,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _feedbackDisplayColor, // Dynamically updates text color to explicitly match experimental directional tints
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 32),

                // --- GLOWING ARENA ENTRY INTERACTION ZONE ---
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GatorTheme.glassRadius),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.02),
                      ],
                    ),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                    boxShadow: [
                      BoxShadow(
                        color: _feedbackDisplayColor.withValues(alpha: 0.06), // Dynamically shadows text zone frames using experimental alert feedback tones
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _isRoundComplete ? 'TARGET RECORD DECLASSIFIED' : 'TACTICAL ENTRY FIELD INPUT',
                        style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _soloController,
                        focusNode: _soloFocusNode,
                        enabled: !_isRoundComplete,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onSubmitted: (_) => _evaluatePlayerGuessSubmission(),
                        style: TextStyle(
                          color: _isRoundComplete ? Colors.greenAccent : GatorTheme.vividOrange,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                        ),
                        decoration: InputDecoration(
                          hintText: _isRoundComplete ? '🎯' : '00',
                          hintStyle: const TextStyle(color: Colors.white12),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- ACTION DISPATCH OPERATION TRIGGER ---
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRoundComplete ? Colors.greenAccent : GatorTheme.vividOrange,
                      foregroundColor: _isRoundComplete ? Colors.black87 : Colors.white,
                    ),
                    onPressed: _evaluatePlayerGuessSubmission,
                    child: Text(_isRoundComplete ? 'NEXT CODE MATRIX TARGET' : 'LAUNCH QUANTUM STRIKE'),
                  ),
                ),
                const SizedBox(height: 28),

                // --- HIGH-VISIBILITY HISTORY SECTION FEED ---
                if (_matchHistoryLog.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ROUND TELEMETRY HISTORICAL LOG',
                          style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: _matchHistoryLog.length,
                            itemBuilder: (context, index) => _buildSoloHistoryRow(_matchHistoryLog[index]),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}