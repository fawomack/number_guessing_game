// --- SYSTEM ARCHITECTURE IMPORT DIRECTIVES ---
import 'package:flutter/material.dart'; // Imports the core Material graphics design library bundle
import 'solo_game_screen.dart'; // Imports the solo game screen component view controller
import 'versus_game_screen.dart'; // Imports the versus arena screen component view controller

// --- MAIN SYSTEM NAVIGATION DASHBOARD CONTROLLER ---
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  // --- REUSABLE GLASSMORPHIC MENU SELECTION CAPSULE BUILDER ---
  Widget _buildMenuButton({
    required BuildContext context, // Demands the application rendering location context pipeline pointer
    required String title, // Requires a text string to serve as the button title label
    required IconData icon, // Requires a graphic icon code point to serve as the button visual anchor
    required Color accentColor, // Requires a design color map to configure text highlights and splash states
    required VoidCallback onTap, // Requires an active functional pointer loop to trigger on touch gestures
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10), // Injects an explicit ten pixel layout spacing block row gap
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24), // Sets an organic twenty-four pixel curve profile rule on layout edges
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.08), // Seeds the primary layer position with an eight percent alpha transparent white
            Colors.white.withValues(alpha: 0.03), // Caps the secondary layer position with a three percent alpha transparent white
          ],
          begin: Alignment.topLeft, // Locks the sweeping linear transformation origin path to the top left frame margin
          end: Alignment.bottomRight, // Projects the sweeping linear transformation destination path to the bottom right frame margin
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15), // Paints a crisp fifteen percent alpha transparent white glass edge stroke
          width: 1, // Sets the structural boundary line gauge thickness parameter strictly to one pixel
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2), // Assigns a muted twenty percent alpha transparent black shadow color map
            blurRadius: 15, // Blurs the cast shadow edge boundaries across a fifteen pixel layout space
            offset: const Offset(0, 8), // Drops layout elements forward across the Z-axis by offsetting the shadow down eight pixels
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent, // Locks the raw material layer coloration rule to fully transparent code blocks
        borderRadius: BorderRadius.circular(24), // Propagates the twenty-four pixel curvature restriction profile down onto material layers
        child: InkWell(
          onTap: onTap, // Binds the outer functional navigation argument loop directly to active touch taps
          borderRadius: BorderRadius.circular(24), // Clips interactive touch splash wave vectors inside the twenty-four pixel curves
          splashColor: accentColor.withValues(alpha: 0.2), // Fires a vibrant twenty percent alpha accent colored ink ripple on tap events
          highlightColor: accentColor.withValues(alpha: 0.05), // Paints a soft five percent alpha accent colored sheen when held down steady
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), // Sets custom vertical twenty and horizontal twenty-four cushioning boundaries
            child: Row(
              children: [
                // --- CONTAINER PLATE FOR ICON GRAPHICS ---
                Container(
                  padding: const EdgeInsets.all(12), // Pads out the internal icon element edges evenly by twelve pixels layout-wide
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15), // Paints the backing plate with a fifteen percent alpha accent translucent ink tint
                    borderRadius: BorderRadius.circular(16), // Curves the internal icon backing plate corners cleanly at sixteen pixels
                  ),
                  child: Icon(icon, color: accentColor, size: 28), // Instantiates the semantic icon vector graphic bound to the accent color scheme
                ),
                const SizedBox(width: 20), // Drops an explicit twenty pixel horizontal spacer block to clear alignment margins
                
                // --- TEXT VIEW FOR BUTTON TITLE SELECTION ---
                Text(
                  title, // Injects the passed title string data directly into the active viewport drawing frame
                  style: const TextStyle(
                    color: Colors.white, // Colors the active label character strings fully solid white layout-wide
                    fontSize: 18, // Locks the layout sizing profile for button character arrays to eighteen points
                    fontWeight: FontWeight.bold, // Formats the selection title typeface characters to a stark bold weight mapping
                    letterSpacing: 0.8, // Adjusts horizontal character layout separation tracking widthwise by zero point eight units
                  ),
                ),
                const Spacer(), // Deploys an elastic layout engine utility block to absorb empty horizontal screen space entirely
                
                // --- TRAILING CHEVRON GLYPH ELEMENT ---
                Icon(
                  Icons.arrow_forward_ios, // Selects the standard iOS style forward pointing arrow indicator vector asset
                  color: Colors.white.withValues(alpha: 0.3), // Mutes the indicator vector appearance down to a subtle thirty percent transparency
                  size: 16, // Lowers the structural icon layout width dimensions down to sixteen logical points
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- MAIN VIEWPORT VISUAL ENGINE DRAW ROUTINES ---
  @override // Instructs the framework compile engine to overwrite the standard parent widget rendering loop calculations
  Widget build(BuildContext context) {
    final orangeColor = Theme.of(context).colorScheme.secondary; // Extracts the master signature orange accent code context from active global themes

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F1123), // Assigns a deep dark midnight space blue hex code value to the origin anchor
              Color(0xFF1D1429), // Assigns a rich charcoal space violet hex code value to the destination anchor
            ],
            begin: Alignment.topLeft, // Locks the immersive linear color shifting base to the top left screen corner boundary
            end: Alignment.bottomRight, // Projects the immersive linear color shifting line down to the bottom right screen corner boundary
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0), // Enforces a solid thirty pixel horizontal outer border margin alignment cap
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Pulls all children components into an aggregated central alignment vertically
              children: [
                const Spacer(), // Deploys an initial top elastic spacer block to push the logo asset down toward visual focus centers

                // --- APP BRANDING LOGO SEGMENT ---
                Container(
                  padding: const EdgeInsets.all(24), // Sets an internal twenty-four pixel padding frame entirely around the center icon asset
                  decoration: BoxDecoration(
                    color: orangeColor.withValues(alpha: 0.1), // Sets a soft ten percent alpha transparent orange interior fill coloration
                    shape: BoxShape.circle, // Configures the backing mask architecture shape profile to a clean perfect geometric circle
                    boxShadow: [
                      BoxShadow(
                        color: orangeColor.withValues(alpha: 0.15), // Sets the bloom glow background aura matrix to fifteen percent alpha orange
                        blurRadius: 40, // Spreads the soft atmospheric bloom out across a massive forty pixel blurring field radius
                        spreadRadius: 5, // Expands the core neon cast density outwards by five pixels from structural center boundaries
                      ),
                    ],
                  ),
                  child: Icon(Icons.tag, color: orangeColor, size: 64), // Draws a giant signature hashtag number game icon at sixty-four points size
                ),
                const SizedBox(height: 24), // Drops an explicit twenty-four pixel vertical padding box to clear logo text lines
                
                // --- TITLE TEXT HIERARCHY ---
                const Text(
                  'NUMBERS', // Injects the core title character string literal directly into the visual render track
                  style: TextStyle(
                    color: Colors.white, // Forces the core logo text string layer to write in ultra clean solid white characters
                    fontSize: 36, // Locks the primary brand identifier text sizing profile directly to thirty-six logical points
                    fontWeight: FontWeight.w900, // Sets the typeface weight configuration to an ultra thick max density black value
                    letterSpacing: 4.0, // Stretches out the horizontal tracking width across character elements by four pixels for tech brand feel
                  ),
                ),
                Text(
                  'THE ULTIMATE CHASE', // Injects the gaming subtitle branding phrase string literal into the drawing flow
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4), // Dims the subtitle text block down to an elegant forty percent transparent white ink
                    fontSize: 12, // Restricts the gaming tagline layout width print footprint strictly to twelve logical points
                    fontWeight: FontWeight.w600, // Hardcodes the tagline letter forms to a solid professional semi-bold weight configuration
                    letterSpacing: 2.0, // Expands horizontal character tracking layout separations by an explicit two logical points widthwise
                  ),
                ),
                
                const Spacer(), // Deploys a mid-tier elastic layout buffer engine to space title text sets from game inputs

                // --- NAVIGATION CONTROL TRACKS ---
                _buildMenuButton(
                  context: context, // Feeds current active navigation contextual location chains directly down into the method
                  title: 'SOLO CAMPAIGN', // Passes the specific solo campaign text string to write inside the capsule layout
                  icon: Icons.person_rounded, // Assigns a rounded individual user avatar system silhouette vector graphic to the block
                  accentColor: orangeColor, // Sets the button theme accent colors directly to the master signature orange scheme
                  onTap: () => Navigator.push(
                    context, // Passes location routing maps down through context tracking parameters
                    MaterialPageRoute(builder: (context) => const SoloGameScreen()), // Compiles a route tracking link building a fresh Solo Game Screen view
                  ),
                ),
                
                _buildMenuButton(
                  context: context, // Passes active runtime app context tracks down into the selection module block loop
                  title: 'VERSUS ARENA', // Passes the competitive arena mode text string to write inside the glass capsule layout
                  icon: Icons.people_alt_rounded, // Assigns a dual user competitive group community silhouette vector graphic to the block
                  accentColor: Colors.cyanAccent, // Injects an aggressive high contrast bright neon cyan accent color code for versus mode differentiation
                  onTap: () => Navigator.push(
                    context, // Passes target application view architecture context trees downwards
                    MaterialPageRoute(builder: (context) => const VersusGameScreen()), // Compiles a route tracking link building a fresh Versus Game Screen view
                  ),
                ),

                const Spacer(), // Deploys a final lower tier elastic spacer block to buffer button grids from lower screen text labels
                
                // --- FOOTER ATTRIBUTION SEGMENT ---
                Text(
                  'v1.0.0 • READY TO PLAY', // Injects the production build specification stamp string directly into layout positions
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.2), // Fades the production build stamp to a minimal twenty percent transparent ghost text look
                    fontSize: 11, // Locks the technical attribution footprint small down to eleven logical scaling points size
                    letterSpacing: 1.2, // Separates technical text elements horizontally across tracking lines by one point two pixels
                  ),
                ),
                const SizedBox(height: 10), // Drops a final static ten pixel padding spacer to offset text lines from system navigation home bars
              ],
            ),
          ),
        ),
      ),
    );
  }
}