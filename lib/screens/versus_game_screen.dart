import 'package:flutter/material.dart';
import '../models/guess_record.dart'; // Imports the structured object data blueprint for guess tracking

// --- STATEFUL SCREEN CONTROLLER SETUP ---
class VersusGameScreen extends StatefulWidget {
  const VersusGameScreen({super.key});

  @override
  State<VersusGameScreen> createState() => _VersusGameScreenState();
}

class _VersusGameScreenState extends State<VersusGameScreen> {
  // --- STATE ENVIRONMENT VARIABLES ---
  String _phase = "setting"; // Alternates engine phases: "setting" (Player 1 setup) or "guessing" (Player 2 chase)
  int? _secretNumber; // Stores Player 1's custom chosen integer target (nullable before lock-in)
  int _attempts = 0; // Tracks Player 2's total valid round submissions
  String _hintMessage = "Player 1: Enter a secret number (1-100)"; // Dynamic text block displaying system hints/warnings
  List<GuessRecord> _guessHistory = []; // Historical log storage array tracking player guess attempts

  // --- INTERFACE HARDWARE ARCHITECTURE CONTROLLERS ---
  final TextEditingController _versusController = TextEditingController(); // Controls input field data extractions
  final FocusNode _versusFocusNode = FocusNode(); // Controls virtual system keyboard focus targeting
  final ScrollController _scrollController = ScrollController(); // Programmatically slides the history viewing wheel

  @override
  void initState() {
    super.initState();
    // Forces keyboard layout visibility immediately upon mounting the screen
    WidgetsBinding.instance.addPostFrameCallback((_) => _versusFocusNode.requestFocus());
  }

  @override
  void dispose() {
    _versusController.dispose(); // Wipes text controller cache to free up RAM context
    _versusFocusNode.dispose(); // Drops target keyboard listener reference safely
    _scrollController.dispose(); // Detaches scrolling hardware driver tracking to block leaks
    super.dispose();
  }

  // --- GAMEPLAY LIFE CYCLE METHODS ---
  void _handleSubmit() {
    int? inputValue = int.tryParse(_versusController.text); // Parses active field data string safely into an integer
    if (inputValue == null) return; // Guard clause neutralizing empty submissions or non-numeric entries

    // Range Protection Guardrail
    if (inputValue < 1 || inputValue > 100) {
      setState(() {
        _hintMessage = "❌ Out of bounds!\nStay between 1 and 100."; // Warning flag text assignment
        _versusController.clear(); // Wipes invalid text entry
        _versusFocusNode.requestFocus(); // Assures keyboard input focus remains locked
      });
      return;
    }

    setState(() {
      if (_phase == "setting") {
        // --- TRANSITION FROM SETUP PHASE TO PLAY PHASE ---
        _secretNumber = inputValue; // Locks user target directly into game engine memory state
        _phase = "guessing"; // Switches global phase tracker to active gameplay cycle
        _hintMessage = "Player 2: Start guessing!"; // Notifies the second participant to take control
        _versusController.clear(); // Visual input field cleanup loop
      } else {
        // --- STANDARD GUESSING LOGIC ROUND CYCLE ---
        _attempts++; // Increments target attempt log value tracker
        if (inputValue == _secretNumber) {
          _hintMessage = "🎉 Player 2 Wins! 🎉\nThey found your number: $_secretNumber!"; // Match celebration text assignment
          _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: inputValue, icon: "🎉")); // Appends terminal winning entry
        } else if (inputValue > _secretNumber!) {
          _hintMessage = "Too High! 📈"; // High indicator update
          _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: inputValue, icon: "📈")); // Appends high guess log capsule
        } else {
          _hintMessage = "Too Low! 📉"; // Low indicator update
          _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: inputValue, icon: "📉")); // Appends low guess log capsule
        }
        _versusController.clear(); // Cleans entry line text display elements
      }

      // Framework micro tasks run post rendering frame loop layout calculations
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          // Rolls history logging row view smoothly to the absolute rightmost edge container
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
        _versusFocusNode.requestFocus(); // Re-establishes field targeting focus for typing efficiency
      });
    });
  }

  void _resetVersusGame() {
    setState(() {
      _phase = "setting"; // Rolls system loop phase tracking baseline backward
      _secretNumber = null; // Purges target numerical instance memory context
      _attempts = 0; // flushes active round metrics data tracking
      _hintMessage = "Player 1: Enter a secret number (1-100)"; // Resets layout label context strings
      _guessHistory = []; // Drops historic collections structures
      _versusController.clear(); // Text box text cleanup loop
      WidgetsBinding.instance.addPostFrameCallback((_) => _versusFocusNode.requestFocus()); // Locks virtual system focus
    });
  }

  // --- COMPONENT VISUAL ENGINE DRAW ROUTINES ---
  @override
  Widget build(BuildContext context) {
    final orangeColor = Theme.of(context).colorScheme.secondary; // Samples master theme design dictionary orange color key
    // Evaluate if game completion constraints match state requirements
    bool isGameOver = _secretNumber != null && _guessHistory.isNotEmpty && _guessHistory.last.guessValue == _secretNumber;

    return Scaffold(
      // --- HEADER APP BAR WRAPPER ---
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent backdrop blending rule
        elevation: 0, // Removes native navigation shadow rendering properties
        automaticallyImplyLeading: false, // Disables automatic backwards back-arrow chevron placements
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28), // Exit control icon button layout rule
            onPressed: () => Navigator.pop(context), // Safely breaks path context route layer back to Main Menu Screen
          ),
          const SizedBox(width: 10), // Boundary margin layout padding spacer
        ],
      ),
      
      // --- CENTRAL VIEWPORT BODY GRID PANEL ---
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0), // Outer viewport padding frame caps
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Groups visual child rows centrally down y-axis tracking
            children: [
              Text(
                _phase == "setting" ? "VERSUS MODE\nSetup" : "VERSUS MODE\nThe Chase", // Multi-phase header title assignment string
                textAlign: TextAlign.center, // Alignment alignment constraint rule
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), // Header typography rule
              ),
              const SizedBox(height: 15), // Layout spacer
              Text(
                _hintMessage,
                textAlign: TextAlign.center, // Alignment alignment constraint rule
                style: TextStyle(color: orangeColor, fontSize: 20, fontWeight: FontWeight.bold), // Action label typography rule
              ),
              const SizedBox(height: 10), // Layout spacer
              if (_phase == "guessing")
                Text(
                  'Attempts: $_attempts',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 16), // Secondary attempt tally visibility layer
                ),
              const SizedBox(height: 25), // Layout spacer

              // --- HORIZONTAL SCROLLING HISTORY DASHBOARD PILLS ---
              if (_guessHistory.isNotEmpty)
                SizedBox(
                  height: 65, // Envelope layout tracking constraints height parameter
                  child: ListView.builder(
                    controller: _scrollController, // Attaches operational program scrolling tracking hook
                    scrollDirection: Axis.horizontal, // Directs engine list flow rendering horizontally rightward
                    shrinkWrap: true, // Condenses outer frame container bounds around operational item counts
                    itemCount: _guessHistory.length, // Establishes loop index thresholds mapping data size parameters
                    itemBuilder: (context, index) {
                      final record = _guessHistory[index]; // Selects localized loop dataset record element instance contexts safely
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6), // Margin framing capsule buffer bounds
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding inside history capsules
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15), // Glass capsule visualization effect color blend
                          borderRadius: BorderRadius.circular(14), // Uniform item container curve parameters
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Vertically centers text labels within layout tracking blocks
                          children: [
                            Text(
                              "Guess ${record.attemptNumber}",
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12), // Attempt position string index label
                            ),
                            Text(
                              "${record.guessValue} ${record.icon}",
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16), // Guess readout variable data format
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 15), // Layout spacer

              // --- DYNAMIC ENTRY TEXTFIELD ELEMENT WRAPPER ---
              if (!isGameOver)
                SizedBox(
                  width: 150, // Fixed physical container item rendering size specification
                  child: TextField(
                    controller: _versusController, // Binds core form data capture handler hook
                    focusNode: _versusFocusNode, // Connects hardware keyboard targeting system
                    keyboardType: TextInputType.number, // Configures default keypad panel to target numbers exclusively
                    obscureText: _phase == "setting", // Hides entry visibility into dots during P1 phase to avoid screen peeping
                    textAlign: TextAlign.center, // Centers active input element typography horizontally inside the field
                    style: TextStyle(color: orangeColor, fontSize: 32, fontWeight: FontWeight.bold), // High visibility value display text styles
                    onSubmitted: (_) => _handleSubmit(), // Routes return/enter keystrokes to evaluate logic loop pipeline natively
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: orangeColor, width: 2)), // Unselected bar rule
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: orangeColor, width: 3)), // Active selector bar rule
                    ),
                  ),
                ),
              const SizedBox(height: 40), // Separation block height boundary spacing gap

              // --- PRIMARY CALL TO ACTION ELEVATED INTERACTION ELEMENT ---
              SizedBox(
                width: double.infinity, // Automatically forces item limits outward to fit layout edge lines
                height: 60, // Universal interaction target height blueprint specifications metric
                child: ElevatedButton(
                  onPressed: isGameOver ? _resetVersusGame : _handleSubmit, // State conditional control execution function selector
                  child: Text(
                    isGameOver ? 'PLAY AGAIN' : (_phase == "setting" ? 'LOCK IN NUMBER' : 'SUBMIT GUESS'), // Multi-phase action button labels
                  ),
                ),
              ),

              // --- BACK BUTTON INJECTION CONTROLS ---
              if (isGameOver) ...[
                const SizedBox(height: 15), // Layout element buffer gap
                SizedBox(
                  width: double.infinity, // Spans full horizontal boundary dimensions widthwise
                  height: 60, // Standard template sizing framework consistency lock-in
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context), // Drops route tier safely back down to parent Main Menu target view
                    child: const Text('BACK TO MAIN MENU'), // Redirection action button typography tag
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}