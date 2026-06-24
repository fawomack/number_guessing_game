// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle
import '../theme/gator_theme.dart'; // References the master design system token profile file
import '../widgets/versus_score_card.dart'; // References subcomponent dependency link for player tracking maps
import '../widgets/versus_history_row.dart'; // References subcomponent dependency link for list tracking rows

// --- CUSTOM HISTORICAL DATA OBJECT TRACKER ---
class VersusAttempt {
  final int guess; // Stores the specific number submitted by the current active guesser
  final String feedback; // Stores text mapping: "Too High ↓", "Too Low ↑", or "Direct Hit! 🎯"
  final Color alertColor; // Holds the explicit color token for visual feedback formatting

  VersusAttempt({
    required this.guess,
    required this.feedback,
    required this.alertColor,
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
  final TextEditingController _versusController = TextEditingController(); // Allocates the memory stream to capture active text typing input
  final FocusNode _versusFocusNode = FocusNode(); // Allocates a persistent focus anchor to control device soft keyboard states
  
  int? _targetNumber; // The secret number currently hidden in the arena (null means we are in a setup phase)
  int _player1Score = 0; // Tracks master match series victories for Player 1
  int _player2Score = 0; // Tracks master match series victories for Player 2
  
  // --- ROLE AND METRIC TRACKING VARIABLES ---
  int _currentRound = 1; // Tracks the battle sub-phase (Round 1: P2 guesses | Round 2: P1 guesses)
  int _player1GuessCount = 0; // Aggregates total attempts taken by Player 1 during their hunting phase
  int _player2GuessCount = 0; // Aggregates total attempts taken by Player 2 during their hunting phase
  
  String _arenaFeedback = "ROUND 1: Player 1, enter a secret number (1-100) for Player 2 to guess!"; // Holds current versus prompt tracking context lines
  Color _feedbackColor = Colors.white; // Controls core status font coloring profiles dynamically
  
  // --- SPLIT HISTORY REGISTRIES ---
  final List<VersusAttempt> _player1History = []; // Explicitly aggregates guess tracking logs for Player 1 (Round 2)
  final List<VersusAttempt> _player2History = []; // Explicitly aggregates guess tracking logs for Player 2 (Round 1)
  
  bool _isRoundOver = false; // Tracks whether the entire two-part match sequence has completely finished
  bool _isIntermission = false; // INTERMISSION HALT: Tracks if Player 2 just won and we are pausing to celebrate before Round 2 setup

  @override
  void initState() {
    super.initState(); // Executes standard parent initialization tasks first
    _versusFocusNode.requestFocus(); // Force soft keyboard open instantly upon screen mounting
  }

  @override
  void dispose() {
    _versusController.dispose(); // Safely teardown the controller memory stream when exiting this context to prevent memory leaks
    _versusFocusNode.dispose(); // Safely teardown the focus management hardware links to clear memory footprints
    super.dispose();
  }

  // --- HARD GAME STATE INITIALIZATION RESET ---
  void _startNewArenaMatch() {
    setState(() {
      _targetNumber = null; // Wipes target reference to drop back into Phase 1 (Setup)
      _isRoundOver = false; // Re-opens processing gates for keyboard entries
      _isIntermission = false; // Clear intermission halts
      _currentRound = 1; // Reset back to initial round pairing
      _player1GuessCount = 0; // Flush competitive metrics
      _player2GuessCount = 0; // Flush competitive metrics
      _player1History.clear(); // Wipes individual log streams
      _player2History.clear(); // Wipes individual log streams
      _versusController.clear(); // Flushes input content fields instantly
      _feedbackColor = Colors.white; // Resets central prompt coloring
      _arenaFeedback = "ROUND 1: Player 1, enter a secret number (1-100) for Player 2 to guess!"; // Resets guidance header text strings
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _versusFocusNode.requestFocus();
      });
    });
  }

  // --- INTERMISSION DISMISSAL ROLE SWAP ROUTER ---
  void _advanceToRoundTwoSetup() {
    setState(() {
      _isIntermission = false; 
      _currentRound = 2; 
      _targetNumber = null; // Forces setup phase input routing next
      _versusController.clear();
      _feedbackColor = Colors.white;
      _arenaFeedback = "ROUND 2: Player 2, enter a secret number (1-100) for Player 1 to guess!";
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _versusFocusNode.requestFocus();
      });
    });
  }

  // --- MASTER ROUTING ENGINE FOR SUBMISSIONS ---
  void _handleActionSubmit() {
    if (_isRoundOver) {
      _startNewArenaMatch(); // Match complete -> trigger master game restart
    } else if (_isIntermission) {
      _advanceToRoundTwoSetup(); // Paused at intermission -> step forward into Round 2 configuration
    } else if (_targetNumber == null) {
      _setSecretNumberPhase(); // No target active -> process setup entry
    } else {
      _processGuessPhase(); // Target active -> evaluate current hunter guess
    }
  }

  // --- PHASE 1: TARGET SETTING LOGIC MATRIX ---
  void _setSecretNumberPhase() {
    final int? secretInput = int.tryParse(_versusController.text); // Parses typed user string content safely into an interactive integer format
    
    if (secretInput == null || secretInput < 1 || secretInput > 100) {
      setState(() {
        _arenaFeedback = "⚠️ Invalid! Please enter a valid number strictly between 1 and 100."; // Injects warning messaging on fail conditions
        _feedbackColor = Colors.amberAccent;
      });
      return;
    }

    setState(() {
      _targetNumber = secretInput; // Safely locks target number parameter into active engine reference fields
      _versusController.clear(); // Instantly clears text string variables out of layout fields
      _feedbackColor = Colors.white;
      
      _arenaFeedback = _currentRound == 1 
          ? "Secret locked! 🔒 Player 2: Start firing guesses!" 
          : "Secret locked! 🔒 Player 1: Start firing guesses!";
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _versusFocusNode.requestFocus();
      });
    });
  }

  // --- PHASE 2: HUNTER GUESS EVALUATION PROCESSOR ---
  void _processGuessPhase() {
    final int? currentGuess = int.tryParse(_versusController.text); // Parses typed guess string content safely into an interactive integer format
    if (currentGuess == null) return; // Completely abort processing tracking streams if the field input is invalid or blank

    setState(() {
      if (_currentRound == 1) {
        _player2GuessCount++; // Increment guess registry tracking for Player 2
      } else {
        _player1GuessCount++; // Increment guess registry tracking for Player 1
      }

      if (currentGuess == _targetNumber) {
        // TARGET CRACKED SUCCESSFULLY
        if (_currentRound == 1) {
          // CELEBRATION INTERMITTENT HALT: Pause execution flow here instead of auto-wiping states
          _isIntermission = true;
          _versusFocusNode.unfocus();
          _feedbackColor = Colors.greenAccent;
          _arenaFeedback = "🎯 Player 2 cracked it in $_player2GuessCount guesses!";
          
          _player2History.insert(0, VersusAttempt(
            guess: currentGuess, 
            feedback: "Correct! 🎯",
            alertColor: Colors.greenAccent,
          ));
          _versusController.clear();
        } else {
          // ROUND 2 FINISHED -> FINAL SHOWDOWN CALCULATION
          _isRoundOver = true;
          _versusFocusNode.unfocus();
          _feedbackColor = Colors.greenAccent;
          
          _player1History.insert(0, VersusAttempt(
            guess: currentGuess, 
            feedback: "Correct! 🎯",
            alertColor: Colors.greenAccent,
          ));
          _versusController.clear();
          _calculateMatchWinner();
        }
      } else {
        // MISSED TARGET: LOG ATTEMPT AND GENERATE COLOR-CODED DIRECTIONAL HINTS
        final bool isTooLow = currentGuess < _targetNumber!;
        final Color trackingTint = isTooLow ? GatorTheme.versusBlue : GatorTheme.vividOrange;
        final String formattedArrowText = isTooLow ? "Too Low ↑" : "Too High ↓";
        final String activeGuesser = _currentRound == 1 ? "Player 2" : "Player 1";
        
        _feedbackColor = trackingTint;
        _arenaFeedback = "$activeGuesser guess was $formattedArrowText";
        
        final VersusAttempt loggedAttempt = VersusAttempt(
          guess: currentGuess,
          feedback: formattedArrowText,
          alertColor: trackingTint,
        );

        if (_currentRound == 1) {
          _player2History.insert(0, loggedAttempt);
        } else {
          _player1History.insert(0, loggedAttempt);
        }
        
        _versusController.clear();
        
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _versusFocusNode.requestFocus();
        });
      }
    });
  }

  // --- SHOWDOWN ENGINE: COMPARSION EVALUATOR ---
  void _calculateMatchWinner() {
    if (_player1GuessCount < _player2GuessCount) {
      _player1Score++;
      _arenaFeedback = "🏆 Player 1 Wins the Arena!\nScore: $_player1GuessCount guesses vs Player 2's $_player2GuessCount!";
    } else if (_player2GuessCount < _player1GuessCount) {
      _player2Score++;
      _arenaFeedback = "🏆 Player 2 Wins the Arena!\nScore: $_player2GuessCount guesses vs Player 1's $_player1GuessCount!";
    } else {
      _arenaFeedback = "🤝 It's a Dead Draw! Both players cracked codes in exactly $_player1GuessCount guesses!";
    }
  }

  // --- MAIN VIEWPORT VISUAL ENGINE DRAW ROUTINES ---
  @override
  Widget build(BuildContext context) {
    final bool isSetupPhase = (_targetNumber == null && !_isIntermission); // Tracks dynamically if we are handling player setups
    
    // Set active interface colors based on who is actively typing/guesser roles
    final Color phaseAccentColor = _isRoundOver 
        ? Colors.greenAccent 
        : (_isIntermission 
            ? Colors.greenAccent 
            : (isSetupPhase 
                ? (_currentRound == 1 ? GatorTheme.vividOrange : GatorTheme.versusBlue)
                : (_currentRound == 1 ? GatorTheme.versusBlue : GatorTheme.vividOrange)));

    // Dynamic title strings mapping setup status parameters
    String boxHeaderLabel = 'TACTICAL HUNTING ZONE';
    if (_isRoundOver) {
      boxHeaderLabel = 'ARENA SUMMARY UNLOCKED';
    } else if (_isIntermission) {
      boxHeaderLabel = 'ROUND 1 VICTORY SECURED';
    } else if (isSetupPhase) {
      boxHeaderLabel = _currentRound == 1 ? 'PLAYER 1: HIDDEN SETUP ZONE' : 'PLAYER 2: HIDDEN SETUP ZONE';
    } else {
      boxHeaderLabel = _currentRound == 1 ? 'PLAYER 2: RUNNING GUESSES' : 'PLAYER 1: RUNNING GUESSES';
    }

    return Scaffold(
      body: Container(
        decoration: GatorTheme.screenGradientBackground, // Leverages global centralized layout gradient matrix wide
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0), // Outer viewport bounding matrix alignment
            child: Column(
              children: [
                const SizedBox(height: 16), // FIX 1: Shrunk header gap down to optimize spacing matrices

                // --- HEADER NAV APP BAR ROW WRAPPER ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'VERSUS ARENA',
                      style: TextStyle(
                        color: GatorTheme.versusBlue,
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
                const SizedBox(height: 16), // FIX 1: Shrunk buffer layout rows

                // --- COMPETITIVE MATCH SCOREBOARD INTERACTION HEADER ---
                Row(
                  children: [
                    VersusScoreCard(
                      player: 'PLAYER 1',
                      score: _player1Score,
                      details: _player1GuessCount > 0 ? 'Guesses: $_player1GuessCount' : 'Status: Setter',
                      color: GatorTheme.vividOrange,
                    ),
                    const SizedBox(width: 16),
                    VersusScoreCard(
                      player: 'PLAYER 2',
                      score: _player2Score,
                      details: _player2GuessCount > 0 ? 'Guesses: $_player2GuessCount' : 'Status: Waiting',
                      color: GatorTheme.versusBlue,
                    ),
                  ],
                ),
                const SizedBox(height: 24), // FIX 1: Replaced massive spacers with controlled compact block padding bounds

                // --- SYSTEM ARENA DYNAMIC FEEDBACK TEXT ROW ---
                Text(
                  _arenaFeedback,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _feedbackColor, // Applies experimental coloring profiles dynamically layout wide
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20), // Controlled padding block 

                // --- GLOWING ARENA ENTRY INTERACTION ZONE ---
                Container(
                  padding: const EdgeInsets.all(20), // Shrunk layout parameters padding lines to fit screens
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
                        color: phaseAccentColor.withValues(alpha: 0.06),
                        blurRadius: 25,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        boxHeaderLabel,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _versusController,
                        focusNode: _versusFocusNode,
                        enabled: (!_isRoundOver && !_isIntermission), // Block interaction if paused at results or intermission frames
                        obscureText: isSetupPhase,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onSubmitted: (_) => _handleActionSubmit(),
                        style: TextStyle(
                          color: phaseAccentColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                        decoration: InputDecoration(
                          hintText: (_isRoundOver || _isIntermission) ? '🎯' : (isSetupPhase ? '• • • •' : '00'),
                          hintStyle: const TextStyle(color: Colors.white12),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16), // Controlled action gap spacer

                // --- ACTION DISPATCH OPERATION TRIGGER ---
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: phaseAccentColor,
                      foregroundColor: (_isRoundOver || _isIntermission) ? Colors.black87 : Colors.white,
                    ),
                    onPressed: _handleActionSubmit,
                    child: Text(
                      _isRoundOver 
                          ? 'PLAY AGAIN' 
                          : (_isIntermission 
                              ? 'CONTINUE TO ROUND 2' // FIX 4: Explicit button click intercept celebration gate phrase
                              : (isSetupPhase ? 'CONFIRM SECRET' : 'LAUNCH STRIKE')),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Reclaimed spatial clearances allocations above tables tracking views

                // --- HIGH-VISIBILITY HISTORY SECTION FEED ---
                // FIX 2: Check if round is over to present the dual split horizontal layout matrix
                if (_isRoundOver)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // PLAYER 1 COLUMN (Left)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'P1 GUESSES (R2)',
                                style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                              ),
                              const SizedBox(height: 6),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: _player1History.length,
                                  itemBuilder: (context, index) => VersusHistoryRow(
                                    attempt: _player1History[index],
                                    guesserName: "Player 1", // Clear designation tags overridden parameters
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12), // Interior split divider gap layout horizon track
                        // PLAYER 2 COLUMN (Right)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'P2 GUESSES (R1)',
                                style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                              ),
                              const SizedBox(height: 6),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: _player2History.length,
                                  itemBuilder: (context, index) => VersusHistoryRow(
                                    attempt: _player2History[index],
                                    guesserName: "Player 2",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else if (_player1History.isNotEmpty || _player2History.isNotEmpty)
                  // Running active round log tracking single view fallback layer
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentRound == 1 ? 'PLAYER 2 HISTORY' : 'PLAYER 1 HISTORY',
                          style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: _currentRound == 1 ? _player2History.length : _player1History.length,
                            itemBuilder: (context, index) => VersusHistoryRow(
                              attempt: _currentRound == 1 ? _player2History[index] : _player1History[index],
                              guesserName: _currentRound == 1 ? "Player 2" : "Player 1",
                            ),
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