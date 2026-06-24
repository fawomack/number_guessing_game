// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle
import '../theme/gator_theme.dart'; // References the master design system token profile file

// --- CUSTOM HISTORICAL DATA OBJECT TRACKER ---
class VersusAttempt {
  final int guess; // Stores the specific number submitted by the current guesser
  final String feedback; // Stores directional hints like "Too High" or "Too Low"

  VersusAttempt({required this.guess, required this.feedback});
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
  final List<VersusAttempt> _arenaHistory = []; // Registers the running sequential history log of guess attempts for the active turn
  bool _isRoundOver = false; // Tracks whether the entire two-part match sequence has completely finished

  @override
  void initState() {
    super.initState(); // Executes standard parent initialization tasks first
    _versusFocusNode.requestFocus(); // Force soft keyboard open instantly upon screen mounting to start phase one immediately
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
      _currentRound = 1; // Reset back to initial round pairing
      _player1GuessCount = 0; // Flush competitive metrics
      _player2GuessCount = 0; // Flush competitive metrics
      _arenaHistory.clear(); // Wipes round log matrices clean for the new match cycle
      _versusController.clear(); // Flushes input content fields instantly
      _arenaFeedback = "ROUND 1: Player 1, enter a secret number (1-100) for Player 2 to guess!"; // Resets guidance header text strings
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _versusFocusNode.requestFocus();
      });
    });
  }

  // --- MASTER ROUTING ENGINE FOR SUBMISSIONS ---
  void _handleActionSubmit() {
    if (_isRoundOver) {
      _startNewArenaMatch(); // Match complete -> trigger reset
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
      });
      return;
    }

    setState(() {
      _targetNumber = secretInput; // Safely locks target number parameter into active engine reference fields
      _versusController.clear(); // Instantly clears text string variables out of layout fields
      
      if (_currentRound == 1) {
        _arenaFeedback = "Secret locked! 🔒 Player 2: Start firing guesses!";
      } else {
        _arenaFeedback = "Secret locked! 🔒 Player 1: Start firing guesses!";
      }
      
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
        // TARGET CRACKED successfully
        if (_currentRound == 1) {
          // ROUND 1 FINISHED -> IMMEDIATE ROLE SWAP SETUP
          _currentRound = 2; 
          _targetNumber = null; // Clear target to force Round 2 setup mode
          _arenaHistory.clear(); // Flush logs clean for Player 1's turn history
          _versusController.clear();
          _arenaFeedback = "🎯 Player 2 cracked it in $_player2GuessCount guesses!\nROUND 2: Player 2, set a secret number for Player 1!";
          
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _versusFocusNode.requestFocus();
          });
        } else {
          // ROUND 2 FINISHED -> FINAL SHOWDOWN CALCULATION
          _isRoundOver = true;
          _versusFocusNode.unfocus(); // Clear screen clutter by dropping soft hardware keyboard layout away entirely
          _arenaHistory.insert(0, VersusAttempt(guess: currentGuess, feedback: "Direct Hit! 🎯"));
          _calculateMatchWinner();
        }
      } else {
        // MISSED TARGET: LOG ATTEMPT AND GENERATE DIRECTIONAL HINTS
        final String direction = currentGuess < _targetNumber! ? "Too Low 📉" : "Too High 📈";
        final String activeGuesser = _currentRound == 1 ? "Player 2" : "Player 1";
        
        _arenaFeedback = "❌ Missed! $activeGuesser, your guess was ${direction.split(' ')[1].toLowerCase()}!";
        
        _arenaHistory.insert(0, VersusAttempt(
          guess: currentGuess,
          feedback: direction,
        ));
        
        _versusController.clear(); // Empty typing zone ready for re-entry sequence
        
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

  // --- REUSABLE SCOREGUARD COMPONENT GRID ELEMENT ---
  Widget _buildScoreCard(String player, int score, String details, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8), // Balances interior typography positions
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
              player,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$score WINS',
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              details, // Displays live active running guess metrics for the player
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- REUSABLE GLASSMORPHIC ARENA HISTORY ROW BUILDER ---
  Widget _buildArenaHistoryRow(VersusAttempt attempt) {
    final String activeGuesser = _currentRound == 1 ? "Player 2" : "Player 1";
    final Color itemAccent = _currentRound == 1 ? GatorTheme.versusBlue : GatorTheme.vividOrange;

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
          color: attempt.feedback.contains('Hit') ? Colors.greenAccent.withValues(alpha: 0.2) : itemAccent.withValues(alpha: 0.15), // Tints historical cells matching outcomes
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes match tracking indices to opposite poles cleanly
        children: [
          Text(
            '$activeGuesser guessed: ${attempt.guess}', // Renders the data integer entry submitted on that index frame
            style: const TextStyle(
              color: Colors.white, // Solid bright white layout-wide font characters sets
              fontSize: 15, // Scannable high visibility list dimensions points
              fontWeight: FontWeight.bold, // Bold emphasis weight mapping rules
            ),
          ),
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

  // --- MAIN VIEWPORT VISUAL ENGINE DRAW ROUTINES ---
  @override
  Widget build(BuildContext context) {
    final bool isSetupPhase = (_targetNumber == null); // Tracks dynamically if we are currently handling player setups
    
    // Set active interface colors based on who is actively typing/guesser roles
    final Color phaseAccentColor = _isRoundOver 
        ? Colors.greenAccent 
        : (isSetupPhase 
            ? (_currentRound == 1 ? GatorTheme.vividOrange : GatorTheme.versusBlue)
            : (_currentRound == 1 ? GatorTheme.versusBlue : GatorTheme.vividOrange));

    // Dynamic title strings mapping setup status parameters
    String boxHeaderLabel = 'TACTICAL HUNTING ZONE';
    if (_isRoundOver) {
      boxHeaderLabel = 'ARENA SUMMARY UNLOCKED';
    } else if (isSetupPhase) {
      boxHeaderLabel = _currentRound == 1 ? 'PLAYER 1: HIDDEN SETUP ZONE' : 'PLAYER 2: HIDDEN SETUP ZONE';
    } else {
      boxHeaderLabel = _currentRound == 1 ? 'PLAYER 2: RUNNING GUESSES' : 'PLAYER 1: RUNNING GUESSES';
    }

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
                    _buildScoreCard(
                      'PLAYER 1', 
                      _player1Score, 
                      _player1GuessCount > 0 ? 'Guesses: $_player1GuessCount' : 'Status: Setter', 
                      GatorTheme.vividOrange
                    ),
                    const SizedBox(width: 16), // Gaps scorecard elements cleanly widthwise across the horizon grid
                    _buildScoreCard(
                      'PLAYER 2', 
                      _player2Score, 
                      _player2GuessCount > 0 ? 'Guesses: $_player2GuessCount' : 'Status: Waiting', 
                      GatorTheme.versusBlue
                    ),
                  ],
                ),
                const Spacer(), // Centers gameplay text boxes elegantly across device viewports

                // --- SYSTEM ARENA DYNAMIC FEEDBACK TEXT ROW ---
                Text(
                  _arenaFeedback, // Direct live feed matching state alerts showing lower/higher or setup progress labels
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white, // High visibility clean solid white typography styling profile
                    fontSize: 16, // Mid-tier readable presentation points
                    fontWeight: FontWeight.w600, // Semi bold configuration weight metrics
                  ),
                ),
                const SizedBox(height: 32), // Layout separation block tracking height dimensions

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
                        color: phaseAccentColor.withValues(alpha: 0.06), // Dynamically shifts shadow ambiance tracking running setup and hunting modes
                        blurRadius: 30, // Spreads glow boundaries widely layout-wide
                        spreadRadius: 2, // Expands core aura structural parameters gently outwards
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        boxHeaderLabel,
                        style: const TextStyle(
                          color: Colors.white70, // Slightly translucent white header layer tint
                          fontSize: 13, // Secondary body caption point dimension settings
                          fontWeight: FontWeight.bold, // Bolds helper label hierarchies
                          letterSpacing: 1.0, // Tracking spacing configuration rules
                        ),
                      ),
                      const SizedBox(height: 8), // Interior block alignment buffer gap
                      
                      // --- CORE TEXT FIELD INTERACTION ELEMENT ---
                      TextField(
                        controller: _versusController, // Binds the text editor stream receiver to capture layout input values
                        focusNode: _versusFocusNode, // Connects our specific focus hook state to maintain uninterrupted keyboard access
                        enabled: !_isRoundOver, // BLOCKS INTERACTION: Shuts off active typing paths fully once rounds end
                        obscureText: isSetupPhase, // STEALTH CONTROL: Hides setup input text strings with bullet masks so players can't screen-peek target parameters
                        keyboardType: TextInputType.number, // Restricts user hardware entries strictly to physical number layout grids
                        textAlign: TextAlign.center, // Keeps active typing streams positioned beautifully in dead layouts center
                        onSubmitted: (_) => _handleActionSubmit(), // Routes execution triggers automatically through selection parsing engines
                        style: TextStyle(
                          color: phaseAccentColor, // Dynamically swaps character color tones matching runtime phase criteria states
                          fontSize: 32, // Giant readable numeric typing scale factor points
                          fontWeight: FontWeight.w900, // Forces heavy numeric presence on screens
                        ),
                        decoration: InputDecoration(
                          hintText: _isRoundOver ? '🏆' : (isSetupPhase ? '• • • •' : '00'), // Morph baseline targets cleanly matching operations maps
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
                      backgroundColor: phaseAccentColor, // Dynamically maps background button fills matching phase tokens
                      foregroundColor: _isRoundOver ? Colors.black87 : Colors.white, // Shifts text characters coloring schema for peak visibility constraints
                    ),
                    onPressed: _handleActionSubmit, // Dispatches commands cleanly directly to our master action evaluation router engine
                    child: Text(
                      _isRoundOver 
                          ? 'PLAY AGAIN' 
                          : (isSetupPhase ? 'CONFIRM SECRET' : 'LAUNCH STRIKE'), // Dynamically shifts display label strings to match active play cycles
                    ),
                  ),
                ),
                const SizedBox(height: 28), // Spatial allocation block above structural lists fields

                // --- HIGH-VISIBILITY HISTORY SECTION FEED ---
                if (_arenaHistory.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentRound == 1 ? 'PLAYER 2 TARGET HISTORY' : 'PLAYER 1 TARGET HISTORY', // Dynamic tracker title headers
                          style: const TextStyle(
                            color: Colors.white38, // Faded taxonomic label color parameters
                            fontSize: 11, // Small functional metadata scaling rules
                            fontWeight: FontWeight.bold, // Structural taxonomy bold mappings
                            letterSpacing: 1.2, // Clean modern font tracking adjustments
                          ),
                        ),
                        const SizedBox(height: 8), // Tiny visual spacing gap below list title header
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