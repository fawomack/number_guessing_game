import 'package:flutter/material.dart';
import 'dart:math'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guessing Game',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF003D82), 
      ),
      home: const MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'NUMBERS\nGAME',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFFF8C00), 
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Versus Edition',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 60),

              // Solo Mode Button
              SizedBox(
                width: double.infinity, 
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C00), 
                    foregroundColor: Colors.white, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SoloGameScreen()),
                    );
                  },
                  child: const Text(
                    'PLAY SOLO',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Versus Mode Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C00), 
                    foregroundColor: Colors.white, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'VERSUS MODE', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom structure to hold both the guess number label and the visual value safely
class GuessRecord {
  final int attemptNumber;
  final int guessValue;
  final String icon;

  GuessRecord({required this.attemptNumber, required this.guessValue, required this.icon});
}

// --- SOLO GAME SCREEN ---
class SoloGameScreen extends StatefulWidget {
  const SoloGameScreen({super.key});

  @override
  State<SoloGameScreen> createState() => _SoloGameScreenState();
}

class _SoloGameScreenState extends State<SoloGameScreen> {
  late int _secretNumber; 
  int _attempts = 0;
  String _hintMessage = "Enter a number from 1 to 100";
  bool _isGameOver = false; 
  
  // CHANGED: Using a custom structured log list to keep tracking data clean
  List<GuessRecord> _guessHistory = [];
  
  final TextEditingController _guessController = TextEditingController();
  final FocusNode _guessFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startNewGame(); 
  }

  @override
  void dispose() {
    _guessFocusNode.dispose();
    _guessController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _startNewGame() {
    setState(() {
      _secretNumber = Random().nextInt(100) + 1; 
      _attempts = 0;
      _hintMessage = "Enter a number from 1 to 100";
      _isGameOver = false;
      _guessHistory = []; 
      _guessController.clear();
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _guessFocusNode.requestFocus();
      });
    });
  }

  void _checkGuess() {
    int? userGuess = int.tryParse(_guessController.text);
    if (userGuess == null) return;

    // FIXED: Range Protection Guardrail! Stops execution if out of boundaries
    if (userGuess < 1 || userGuess > 100) {
      setState(() {
        _hintMessage = "❌ Out of bounds!\nStay between 1 and 100.";
        _guessController.clear();
        _guessFocusNode.requestFocus();
      });
      return; 
    }

    setState(() {
      _attempts++; 

      if (userGuess == _secretNumber) {
        _hintMessage = "🎉 You Win! 🎉\nThe number was $_secretNumber!";
        _isGameOver = true;
        _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: userGuess, icon: "🎉"));
      } else if (userGuess > _secretNumber) {
        _hintMessage = "Too High! 📈";
        _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: userGuess, icon: "📈")); 
      } else {
        _hintMessage = "Too Low! 📉";
        _guessHistory.add(GuessRecord(attemptNumber: _attempts, guessValue: userGuess, icon: "📉")); 
      }
      
      _guessController.clear();
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
        _guessFocusNode.requestFocus();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, 
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.pop(context);
            },
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
              const Text(
                'I picked a number!\nNow you have to guess.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              
              Text(
                _hintMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFFFF8C00), fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              
              Text(
                'Attempts: $_attempts',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 16),
              ),
              const SizedBox(height: 25),

              // FIXED: Upgraded layout cards to stack labels neatly and render in white text
              if (_guessHistory.isNotEmpty)
                SizedBox(
                  height: 65, // Expanded height slightly to accommodate the stacked text lines comfortably
                  child: ListView.builder(
                    controller: _scrollController, 
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(), 
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
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 2),
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

              if (!_isGameOver)
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: _guessController,
                    focusNode: _guessFocusNode, 
                    keyboardType: TextInputType.number, 
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xFFFF8C00), fontSize: 32, fontWeight: FontWeight.bold),
                    onSubmitted: (_) => _checkGuess(), 
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFF8C00), width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFF8C00), width: 3),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C00),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isGameOver ? _startNewGame : _checkGuess,
                  child: Text(
                    _isGameOver ? 'PLAY AGAIN' : 'SUBMIT GUESS', 
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              if (_isGameOver) ...[
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2), 
                      foregroundColor: Colors.white, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.pop(context); 
                    },
                    child: const Text('BACK TO MAIN MENU', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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