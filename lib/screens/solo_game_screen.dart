import 'package:flutter/material.dart';
import 'dart:math'; // Imports mathematical utilities to handle the random number generation
import '../models/guess_record.dart'; // Imports the structured object data blueprint for guess tracking

// --- STATEFUL SCREEN CONTROLLER SETUP ---
class SoloGameScreen extends StatefulWidget {
  const SoloGameScreen({super.key});

  @override
  State<SoloGameScreen> createState() => _SoloGameScreenState();
}

class _SoloGameScreenState extends State<SoloGameScreen> {
  // --- STATE ENVIRONMENT VARIABLES ---
  late int _secretNumber; // The random target integer chosen by the computer that the player must find
  int _attempts = 0; // Tracks the aggregate valid submission loop count
  String _hintMessage = "Enter a number from 1 to 100"; // Dynamic text block displaying system hints/warnings
  bool _isGameOver = false; // Flag tracking if the winning guess matches the target integer
  List<GuessRecord> _guessHistory = []; // List of custom objects holding historical round information
  
  // --- INTERFACE HARDWARE ARCHITECTURE CONTROLLERS ---
  final TextEditingController _guessController = TextEditingController(); // Controls the extraction of string data from input
  final FocusNode _guessFocusNode = FocusNode(); // Forces focus management control over the virtual system keyboard
  final ScrollController _scrollController = ScrollController(); // Hardware hook controlling programmatic view sliding

  @override
  void initState() {
    super.initState();
    _startNewGame(); // Automatically seeds the engine with a target number on screen mount
  }

  @override
  void dispose() {
    _guessFocusNode.dispose(); // Releases the focus instance memory loop safely from system tracking
    _guessController.dispose(); // Destroys the text tracking input buffer context
    _scrollController.dispose(); // Drops the hardware listener to prevent layout scrolling memory leaks
    super.dispose();
  }

  // --- GAMEPLAY LIFE CYCLE METHODS ---
  void _startNewGame() {
    setState(() {
      _secretNumber = Random().nextInt(100) + 1; // Picks an integer from 0-99 and increments it to map from 1 to 100
      _attempts = 0; // Wipes attempt tracking counter context
      _hintMessage = "Enter a number from 1 to 100"; // Resets user feedback messaging
      _isGameOver = false; // Opens the user text input view pipeline
      _guessHistory = []; // Clears historical log list entries
      _guessController.clear(); // Visual input cleanup loop
      // Locks keyboard viewport back into full focus immediately on the next rendering pass frame context
      WidgetsBinding.instance.addPostFrameCallback((_) => _guessFocusNode.requestFocus());
    });
  }

  void _checkGuess() {
    int? userGuess = int.tryParse(_guessController.text); // Converts field value safely to a number, or null if empty
    if (userGuess == null) return; // Immediate cancellation guard against unparseable gibberish or empty clicks

    // Guardrail ensuring inputs map strictly to our designated range parameters without wasting a valid round attempt
    if (userGuess < 1 || userGuess > 100) {
      setState(() {
        _hintMessage = "❌ Out of bounds!\nStay between 1 and 100."; // Warning flag text assignment
        _guessController.clear(); // Wipes invalid text input
        _guessFocusNode.requestFocus(); // Forces keyboard persistence focus
      });
      return; 
    }

    setState(() {
      _attempts++; // Increments attempt count only after passing validation rules

      if (userGuess == _secretNumber) {
        _hintMessage = "🎉 You Win! 🎉\nThe number was $_secretNumber!"; // Win state display
        _isGameOver = true; // Flips game state control flag
        _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: userGuess, icon: "🎉")); // Logs win event object
      } else if (userGuess > _secretNumber) {
        _hintMessage = "Too High! 📈"; // High hint text adjustment
        _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: userGuess, icon: "📈")); // Logs high guess object
      } else {
        _hintMessage = "Too Low! 📉"; // Low hint text adjustment
        _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: userGuess, icon: "📉")); // Logs low guess object
      }
      
      _guessController.clear(); // Resets layout form text field presentation values
      
      // Post frame macro logic handles history animation sliding and virtual focus locking routines natively
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          // Programs the layout viewer to slide rightward to show the latest entry cleanly
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent, 
            duration: const Duration(milliseconds: 200), 
            curve: Curves.easeOut,
          );
        }
        
        // A tiny 20ms delay lets Android finish its native layout shift before we demand focus back
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && !_isGameOver) {
            _guessFocusNode.requestFocus(); // Overrides native mobile layout layout transitions to lock keyboard focus
          }
        });
      });
    });
  }

  // --- COMPONENT VISUAL ENGINE DRAW ROUTINES ---
  @override
  Widget build(BuildContext context) {
    final orangeColor = Theme.of(context).colorScheme.secondary; // Dynamically pulls master orange accent value

    return Scaffold(
      resizeToAvoidBottomInset: false, // Forces layout boundaries to remain static so button clicks don't break keyboard focus
      // --- HEADER APP BAR WRAPPER ---
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Clears default bar coloration background layer
        elevation: 0, // Cuts layout shadow thickness
        automaticallyImplyLeading: false, // Prevents default back arrow button placement from rendering
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28), // White escape dashboard button icon style
            onPressed: () => Navigator.pop(context), // Pops route context to slip backward safely into Main Menu
          ),
          const SizedBox(width: 10), // Layout offset buffer
        ],
      ),
      
      // --- CENTRAL VIEWPORT BODY GRID PANEL ---
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0), // Margin tracking boundary caps
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Groups viewport alignment elements vertically central
            children: [
              const Text(
                'I picked a number!\nNow you have to guess.',
                textAlign: TextAlign.center, // Alignment format rule
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), // Title typography rule
              ),
              const SizedBox(height: 15), // Layout spatial padding separation box
              Text(
                _hintMessage,
                textAlign: TextAlign.center, // Alignment format rule
                style: TextStyle(color: orangeColor, fontSize: 20, fontWeight: FontWeight.bold), // Subtitle typography rule
              ),
              const SizedBox(height: 10), // Layout spatial padding separation box
              Text(
                'Attempts: $_attempts',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 16), // Ghosted attempt layout tracking
              ),
              const SizedBox(height: 25), // Layout spatial padding separation box

              // --- HORIZONTAL SCROLLING HISTORY DASHBOARD PILLS ---
              if (_guessHistory.isNotEmpty)
                SizedBox(
                  height: 65, // Static envelope height to safely wrap vertical stacked layout pairs
                  child: ListView.builder(
                    controller: _scrollController, // Links scroll controller hardware to list viewer instance
                    scrollDirection: Axis.horizontal, // Flips axis flow from traditional vertical down to horizontal rightward
                    shrinkWrap: true, // Sizes list viewport wrapper container closely around elements
                    physics: const BouncingScrollPhysics(), // Adds bounce feedback curves
                    itemCount: _guessHistory.length, // Dictates total list data rendering volume boundaries
                    itemBuilder: (context, index) {
                      final record = _guessHistory[index]; // Extracts record model structure instance context safely
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6), // Margin framing capsule buffer bounds
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding inside history capsules
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15), // Semi-transparent glass capsule layer coloration rule
                          borderRadius: BorderRadius.circular(14), // Rounded history item corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Centers child text views inside capsules
                          children: [
                            Text(
                              "Guess ${record.attemptNumber}",
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12, fontWeight: FontWeight.w500), // Grey capsule index label string style
                            ),
                            const SizedBox(height: 2), // Mini text element gap
                            Text(
                              "${record.guessValue} ${record.icon}",
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16), // Bold value readout string style
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 15), // Layout spatial padding separation box

              // --- DYNAMIC ENTRY TEXTFIELD ELEMENT WRAPPER ---
              if (!_isGameOver)
                SizedBox(
                  width: 150, // Fixed horizontal input text block dimension wrapper
                  child: TextField(
                    controller: _guessController, // Hooks input capture controller pipeline
                    focusNode: _guessFocusNode, // Hooks internal hardware key mapping framework
                    keyboardType: TextInputType.number, // Reconfigures system layout panel configuration to numeric mode keys
                    textInputAction: TextInputAction.go, // Restructures native platform action keys to prevent keyboard dropouts
                    textAlign: TextAlign.center, // Centers active user character entry positioning alignment
                    style: TextStyle(color: orangeColor, fontSize: 32, fontWeight: FontWeight.bold), // Giant orange active text typography
                    onSubmitted: (_) => _checkGuess(), // Automatically invokes validation logic loop on keyboard Enter key hits
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: orangeColor, width: 2)), // Unselected underline style
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: orangeColor, width: 3)), // Selected underline style
                    ),
                  ),
                ),
              const SizedBox(height: 40), // Giant padding gap separating operations layout blocks

              // --- PRIMARY CALL TO ACTION ELEVATED INTERACTION ELEMENT ---
              SizedBox(
                width: double.infinity, // Automatically spans full screen constraints widthwise
                height: 60, // Fixed height profile blueprint matching layout specifications
                child: ElevatedButton(
                  onPressed: _isGameOver ? _startNewGame : _checkGuess, // Multi-phase branch conditional function firing mapping
                  child: Text(_isGameOver ? 'PLAY AGAIN' : 'SUBMIT GUESS'), // Phase structural action label selection
                ),
              ),

              // --- BACK BUTTON INJECTION CONTROLS ---
              if (_isGameOver) ...[
                const SizedBox(height: 15), // Padding spacer
                SizedBox(
                  width: double.infinity, // Spans full horizontal layout tracking boundaries
                  height: 60, // Fixed layout size specification matching primary interaction rows
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context), // Pops viewport back down context chain tracking onto Main Menu Screen
                    child: const Text('BACK TO MAIN MENU'), // Hollow menu redirect indicator label text
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