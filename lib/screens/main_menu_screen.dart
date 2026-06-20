import 'package:flutter/material.dart';
import 'solo_game_screen.dart';
import 'versus_game_screen.dart';

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
              Text(
                'NUMBERS\nGAME',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary, 
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

              SizedBox(
                width: double.infinity, 
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SoloGameScreen()),
                    );
                  },
                  child: const Text('PLAY SOLO'),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const VersusGameScreen()),
                    );
                  },
                  child: const Text('VERSUS MODE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}