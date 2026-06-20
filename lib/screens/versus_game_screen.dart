import 'package:flutter/material.dart';
import '../models/guess_record.dart'; // Imports the structured object data blueprint for guess tracking

// --- STATEFUL SCREEN CONTROLLER SETUP ---
class VersusGameScreen extends StatefulWidget {
  const VersusGameScreen({super.key});

  @override
  State<VersusGameScreen> createState() => _VersusGameScreenState();
}

class _VersusGameScreenState extends State<VersusGameScreen> {
  // --- MATCH STATE ENGINE VARIABLES ---
  String _phase = "p1Setting"; // Tracking phases: "p1Setting", "p2Guessing", "p2Setting", "p1Guessing", "matchOver"
  int? _secretNumber; // Stores the active target number for the current guessing player
  int _attempts = 0; // Tracks valid attempts for the current turn
  String _hintMessage = "Player 1:\nEnter your secret number (1-100)"; // Dynamic HUD hint system
  
  // --- INDEPENDENT HISTORICAL LOG CONTAINERS ---
  List<GuessRecord> _player2GuessHistory = []; // Stores Player 2's historical logs from Leg 1
  List<GuessRecord> _player1GuessHistory = []; // Stores Player 1's historical logs from Leg 2

  // --- COMPETITIVE MATCH SCOREBOARD ---
  int? _player2FinalScore; // Tracks how many attempts Player 2 needed to win Leg 1
  int? _player1FinalScore; // Tracks how many attempts Player 1 needed to win Leg 2

  // --- INTERFACE HARDWARE ARCHITECTURE CONTROLLERS ---
  final TextEditingController _versusController = TextEditingController(); // Controls input field data extractions
  final FocusNode _versusFocusNode = FocusNode(); // Controls virtual system keyboard focus targeting
  final ScrollController _scrollController = ScrollController(); // Programmatically slides the history viewing wheel

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _versusFocusNode.requestFocus());
  }

  @override
  void dispose() {
    _versusController.dispose();
    _versusFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // --- HELPER WRAPPER TO GET CURRENT ACTIVE HISTORY ---
  List<GuessRecord> _getActiveHistory() {
    if (_phase == "p2Guessing") return _player2GuessHistory;
    if (_phase == "p1Guessing") return _player1GuessHistory;
    return [];
  }

  // --- CENTRAL GAME LOOP ENGINE ---
  void _handleSubmit() {
    int? inputValue = int.tryParse(_versusController.text);
    if (inputValue == null) return;

    if (inputValue < 1 || inputValue > 100) {
      setState(() {
        _hintMessage = "❌ Out of bounds!\nStay between 1 and 100.";
        _versusController.clear();
        _versusFocusNode.requestFocus();
      });
      return;
    }

    setState(() {
      // --- PHASE 1: PLAYER 1 LOCKS IN SECRET NUMBER ---
      if (_phase == "p1Setting") {
        _secretNumber = inputValue;
        _phase = "p2Guessing";
        _hintMessage = "Player 2:\nStart guessing Player 1's number!";
        _versusController.clear();
      } 
      // --- PHASE 2: PLAYER 2 IS ACTIVE GUESSER ---
      else if (_phase == "p2Guessing") {
        _attempts++;
        if (inputValue == _secretNumber) {
          _player2FinalScore = _attempts;
          _hintMessage = "🎉 Player 2 Found It! 🎉\nIt took you $_attempts attempts.";
          _player2GuessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: inputValue, icon: "🎉"));
        } else {
          _hintMessage = inputValue > _secretNumber! ? "Too High! 📈" : "Too Low! 📉";
          _player2GuessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: inputValue, icon: inputValue > _secretNumber! ? "📈" : "📉"));
        }
        _versusController.clear();
      } 
      // --- PHASE 3: PLAYER 2 LOCKS IN SECRET NUMBER ---
      else if (_phase == "p2Setting") {
        _secretNumber = inputValue;
        _phase = "p1Guessing";
        _hintMessage = "Player 1:\nStart guessing Player 2's number!";
        _versusController.clear();
      } 
      // --- PHASE 4: PLAYER 1 IS ACTIVE GUESSER ---
      else if (_phase == "p1Guessing") {
        _attempts++;
        if (inputValue == _secretNumber) {
          _player1FinalScore = _attempts;
          _phase = "matchOver";
          _hintMessage = _determineWinnerMessage();
          _player1GuessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: inputValue, icon: "🎉"));
        } else {
          _hintMessage = inputValue > _secretNumber! ? "Too High! 📈" : "Too Low! 📉";
          _player1GuessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: inputValue, icon: inputValue > _secretNumber! ? "📈" : "📉"));
        }
        _versusController.clear();
      }

      // Framework micro tasks run post rendering frame loop layout calculations
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
        
        // Fixes the mobile focus kick-out bug by waiting out the native OS layout cycle
        Future.delayed(const Duration(milliseconds: 20), () {
          if (mounted && _phase != "matchOver") {
            _versusFocusNode.requestFocus();
          }
        });
      });
    });
  }

  // --- TRANSITION TRIGGER BETWEEN MATCH LEGS ---
  void _advanceToNextLeg() {
    setState(() {
      _phase = "p2Setting";
      _secretNumber = null;
      _attempts = 0;
      _hintMessage = "Player 2:\nEnter your secret number (1-100)";
      _versusController.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) => _versusFocusNode.requestFocus());
    });
  }

  String _determineWinnerMessage() {
    if (_player1FinalScore! < _player2FinalScore!) {
      return "🏆 Player 1 Wins the Match! 🏆";
    } else if (_player2FinalScore! < _player1FinalScore!) {
      return "🏆 Player 2 Wins the Match! 🏆";
    } else {
      return "🤝 It's a Dead Draw! 🤝";
    }
  }

  // --- TOTAL SYSTEM RESET REBOOT ---
  void _resetEntireMatch() {
    setState(() {
      _phase = "p1Setting";
      _secretNumber = null;
      _attempts = 0;
      _hintMessage = "Player 1:\nEnter your secret number (1-100)";
      _player2GuessHistory = [];
      _player1GuessHistory = [];
      _player1FinalScore = null;
      _player2FinalScore = null;
      _versusController.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) => _versusFocusNode.requestFocus());
    });
  }

  // --- REUSABLE HISTORY ROW BUILDER WIDGET ---
  Widget _buildHistoryRow(String title, List<GuessRecord> history) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 65,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final record = history[index];
              return Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Guess ${record.attemptNumber}",
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
                    ),
                    Text(
                      "${record.guessValue} ${record.icon}",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final orangeColor = Theme.of(context).colorScheme.secondary;
    
    bool isLeg1Over = _phase == "p2Guessing" && _player2FinalScore != null;
    bool isMatchOver = _phase == "matchOver";
    bool isSettingPhase = _phase == "p1Setting" || _phase == "p2Setting";
    List<GuessRecord> currentHistory = _getActiveHistory();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView( // Prevents layout overflows when the scoreboard stretches out
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isSettingPhase ? "VERSUS MODE\nSetup" : "VERSUS MODE\nThe Chase",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  _hintMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: orangeColor, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                
                if (_phase == "p2Guessing" || _phase == "p1Guessing")
                  Text(
                    'Attempts: $_attempts',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 16),
                  ),
                const SizedBox(height: 25),

                // --- LIVE ACTIVE ROUND HISTORY (Shown mid-game) ---
                if (!isMatchOver && currentHistory.isNotEmpty) ...[
                  SizedBox(
                    height: 65,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: currentHistory.length,
                      itemBuilder: (context, index) {
                        final record = currentHistory[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Guess ${record.attemptNumber}",
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
                              ),
                              Text(
                                "${record.guessValue} ${record.icon}",
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                ],

                // --- END OF MATCH SCOREBOARD: REVEALS DUAL HISTORIES WRAPPER ---
                if (isMatchOver) ...[
                  _buildHistoryRow("Player 1's Guesses (Score: $_player1FinalScore)", _player1GuessHistory),
                  const SizedBox(height: 20),
                  _buildHistoryRow("Player 2's Guesses (Score: $_player2FinalScore)", _player2GuessHistory),
                  const SizedBox(height: 30),
                ],

                // --- INPUT FIELD: HIDDEN IF A PHASE IS COMPLETE ---
                if (!isLeg1Over && !isMatchOver)
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _versusController,
                      focusNode: _versusFocusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.go, // Restructures native platform action keys to prevent keyboard dropouts
                      obscureText: isSettingPhase,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: orangeColor, fontSize: 32, fontWeight: FontWeight.bold),
                      onSubmitted: (_) => _handleSubmit(),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: orangeColor, width: 2)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: orangeColor, width: 3)),
                      ),
                    ),
                  ),
                const SizedBox(height: 40),

                // --- MAIN CALL TO ACTION DYNAMIC BUTTON ---
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: isMatchOver 
                        ? _resetEntireMatch 
                        : (isLeg1Over ? _advanceToNextLeg : _handleSubmit),
                    child: Text(
                      isMatchOver 
                          ? 'PLAY NEW MATCH' 
                          : (isLeg1Over 
                              ? 'NEXT PLAYER\'S TURN' 
                              : (isSettingPhase ? 'LOCK IN NUMBER' : 'SUBMIT GUESS')),
                    ),
                  ),
                ),

                // --- ESCAPE ROUTE TO MAIN MENU ---
                if (isMatchOver) ...[
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('BACK TO MAIN MENU'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}