import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guessing Game',
      // FIXED: This line completely removes the red "Debug" banner!
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
              // Title Text
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

// --- SOLO GAME SCREEN ---
class SoloGameScreen extends StatefulWidget {
  const SoloGameScreen({super.key});

  @override
  State<SoloGameScreen> createState() => _SoloGameScreenState();
}

class _SoloGameScreenState extends State<SoloGameScreen> {
  int _secretNumber = 42; 
  int _attempts = 0;
  String _hintMessage = "Enter a number from 1 to 100";
  
  final TextEditingController _guessController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Prevents Flutter from forcing a left back arrow
        actions: [
          // FIXED: Moved the 'X' button to the top-right actions menu!
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 10), // Gives the button a tiny bit of breathing room from the edge
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // FIXED: Added intro text above the hint message
              const Text(
                'I picked a number!\nNow you have to guess.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              
              // Hint message indicator
              Text(
                _hintMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFFF8C00), // Switched to orange to prioritize it visually!
                  fontSize: 18, 
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              
              // Attempts tracker text
              Text(
                'Attempts: $_attempts',
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
              ),
              const SizedBox(height: 40),

              // Number pad input box
              SizedBox(
                width: 150,
                child: TextField(
                  controller: _guessController,
                  keyboardType: TextInputType.number, 
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFFFF8C00), fontSize: 32, fontWeight: FontWeight.bold),
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

              // Submit Guess Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C00),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    // Logic will go here next!
                  },
                  child: const Text('SUBMIT GUESS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}