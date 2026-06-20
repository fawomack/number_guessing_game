// Defines a custom blueprint object class structure to securely manage historical round logs
class GuessRecord {
  final int attemptNumber; // Tracks the sequential placement count index (e.g., Guess 1, Guess 2)
  final int guessValue;    // Stores the exact numerical value typed into the field by the user
  final String icon;       // Houses the specific status tracking icon string (e.g., '📈', '📉', '🎉')

  // Constructor method block requiring all three variable points to be provided whenever an instance is created
  GuessRecord({
    required this.attemptNumber, 
    required this.guessValue, 
    required this.icon,
  });
}