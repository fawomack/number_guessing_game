import 'package:flutter/material.dart';
import '../models/guess_record.dart';

class VersusGameScreen extends StatefulWidget {
  const VersusGameScreen({super.key});

  @override
  State<VersusGameScreen> createState() => _VersusGameScreenState();
}

class _VersusGameScreenState extends State<VersusGameScreen> {
  String _phase = "setting"; 
  int? _secretNumber;
  int _attempts = 0;
  String _hintMessage = "Player 1: Enter a secret number (1-100)";
  List<GuessRecord> _guessHistory = [];

  final TextEditingController _versusController = TextEditingController();
  final FocusNode _versusFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

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
      if (_phase == "setting") {
        _secretNumber = inputValue;
        _phase = "guessing";
        _hintMessage = "Player 2: Start guessing!";
        _versusController.clear();
      } else {
        _attempts++;
        if (inputValue == _secretNumber) {
          _hintMessage = "🎉 Player 2 Wins! 🎉\nThey found your number: $_secretNumber!";
          _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: inputValue, icon: "🎉"));
        } else if (inputValue > _secretNumber!) {
          _hintMessage = "Too High! 📈";
          _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: inputValue, icon: "📈"));
        } else {
          _hintMessage = "Too Low! 📉";
          _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: inputValue, icon: "📉"));
        }
        _versusController.clear();
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
        }
        _versusFocusNode.requestFocus();
      });
    });
  }

  void _resetVersusGame() {
    setState(() {
      _phase = "setting";
      _secretNumber = null;
      _attempts = 0;
      _hintMessage = "Player 1: Enter a secret number (1-100)";
      _guessHistory = [];
      _versusController.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) => _versusFocusNode.requestFocus());
    });
  }

  @override
  Widget build(BuildContext context) {
    final orangeColor = Theme.of(context).colorScheme.secondary;
    bool isGameOver = _secretNumber != null && _guessHistory.isNotEmpty && _guessHistory.last.guessValue == _secretNumber;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _phase == "setting" ? "VERSUS MODE\nSetup" : "VERSUS MODE\nThe Chase",
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
              if (_phase == "guessing")
                Text(
                  'Attempts: $_attempts',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 16),
                ),
              const SizedBox(height: 25),

              if (_guessHistory.isNotEmpty)
                SizedBox(
                  height: 65,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _guessHistory.length,
                    itemBuilder: (context, index) {
                      final record = _guessHistory[index];
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

              if (!isGameOver)
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: _versusController,
                    focusNode: _versusFocusNode,
                    keyboardType: TextInputType.number,
                    obscureText: _phase == "setting", 
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

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: isGameOver ? _resetVersusGame : _handleSubmit,
                  child: Text(
                    isGameOver ? 'PLAY AGAIN' : (_phase == "setting" ? 'LOCK IN NUMBER' : 'SUBMIT GUESS'),
                  ),
                ),
              ),

              if (isGameOver) ...[
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
    );
  }
}