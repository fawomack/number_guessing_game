import 'package:flutter/material.dart';
import 'solo_game_screen.dart'; // Links main menu to Solo gameplay file
import 'versus_game_screen.dart'; // Links main menu to Versus gameplay file

// MainMenuScreen is a StatelessWidget since it displays static branding buttons without local state changes
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0), // Margins on left and right sides
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers menu layout alignment vertically
            children: [
              // --- TITLE TEXT GRAPHIC ---
              Text(
                'NUMBERS\nGAME',
                textAlign: TextAlign.center, // Centers text block alignment horizontally
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary, // Dynamic link reading master orange accent
                  fontSize: 48, // Large layout header font size
                  fontWeight: FontWeight.w600, // Medium-Bold letter weight thickness
                  letterSpacing: 1.5, // Expanded layout horizontal tracking spacing
                ),
              ),
              const SizedBox(height: 10), // Padding buffer separating header text lines
              const Text(
                'Versus Edition',
                style: TextStyle(
                  color: Colors.white, // Custom subtitle text color
                  fontSize: 18, // Subtitle font size scaling
                  fontStyle: FontStyle.italic, // Slanted aesthetic style configuration
                ),
              ),
              const SizedBox(height: 60), // Giant padding gap pushing title from actions block

              // --- PLAY SOLO BUTTON WRAPPER ---
              SizedBox(
                width: double.infinity, // Forces button container to stretch full layout width
                height: 60, // Fixed physical button touch canvas height
                child: ElevatedButton(
                  onPressed: () {
                    // Pushes Solo mode onto the screen navigation stack framework
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SoloGameScreen()),
                    );
                  },
                  child: const Text('PLAY SOLO'),
                ),
              ),
              const SizedBox(height: 20), // Padding separation gap between both buttons

              // --- VERSUS MODE BUTTON WRAPPER ---
              SizedBox(
                width: double.infinity, // Forces button container to stretch full layout width
                height: 60, // Fixed physical button touch canvas height
                child: ElevatedButton(
                  onPressed: () {
                    // Pushes Versus mode onto the screen navigation stack framework
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