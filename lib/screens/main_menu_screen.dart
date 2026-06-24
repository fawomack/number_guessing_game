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
            Colors.white.withValues(alpha: 0.12), // Increases glass backing to twelve percent alpha to pop against the brighter background
            Colors.white.withValues(alpha: 0.04), // Caps the secondary layer position with a four percent alpha transparent white
          ],
          begin: Alignment.topLeft, // Locks the sweeping linear transformation origin path to the top left frame margin
          end: Alignment.bottomRight, // Projects the sweeping linear transformation destination path to the bottom right frame margin
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.20), // Sharpens the glass edge border line to twenty percent alpha opacity
          width: 1, // Sets the structural boundary line gauge thickness parameter strictly to one pixel
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18), // Softens the drop shadow density slightly to blend with the richer blue values
            blurRadius: 18, // Blurs the cast shadow edge boundaries across an eighteen pixel layout space
            offset: const Offset(0, 6), // Drops layout elements forward across the Z-axis by offsetting the shadow down six pixels
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent, // Locks the raw material layer coloration rule to fully transparent code blocks
        borderRadius: BorderRadius.circular(24), // Propagates the twenty-four pixel curvature restriction profile down onto material layers
        child: InkWell(
          onTap: onTap, // Binds the outer functional navigation argument loop directly to active touch taps
          borderRadius: BorderRadius.circular(24), // Clips interactive touch splash wave vectors inside the twenty-four pixel curves
          splashColor: accentColor.withValues(alpha: 0.25), // Fires a vibrant twenty-five percent alpha accent colored ink ripple on tap events
          highlightColor: accentColor.withValues(alpha: 0.08), // Paints a soft eight percent alpha accent colored sheen when held down steady
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), // Sets custom vertical twenty and horizontal twenty-four cushioning boundaries
            child: Row(
              children: [
                // --- CONTAINER PLATE FOR ICON GRAPHICS ---
                Container(
                  padding: const EdgeInsets.all(12), // Pads out the internal icon element edges evenly by twelve pixels layout-wide
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.18), // Increases icon backing plate saturation to an eighteen percent alpha tint
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
                  color: Colors.white.withValues(alpha: 0.45), // Brightens the chevron glyph pointer to forty-five percent opacity for crisp visibility
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
              Color(0xFF0021A5), // Swaps out the dark midnight navy for a vibrant, saturated official Gator Royal Blue anchor
              Color(0xFF0A1E3F), // Transitions into a clean, rich athletic deep navy base rather than flat black
            ],
            begin: Alignment.topCenter, // Shifts the gradient path to sweep from straight top down for maximum uniform lighting
            end: Alignment.bottomCenter, // Drops the destination transformation terminal point directly to the lower boundary edge
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
                    color: orangeColor.withValues(alpha: 0.15), // Deepens the interior icon fill blend ratio to fifteen percent alpha
                    shape: BoxShape.circle, // Configures the backing mask architecture shape profile to a clean perfect geometric circle
                    boxShadow: [
                      BoxShadow(
                        color: orangeColor.withValues(alpha: 0.25), // Amplifies the neon backing aura density up to twenty-five percent orange
                        blurRadius: 35, // Tightens the blur range slightly to give a punchier, brighter core lighting bloom effect
                        spreadRadius: 6, // Projects the active orange aura outwards by six full logical units from the boundary lines
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
                    fontWeight: FontWeight.w900, // Sets the typeface weight configuration to an ultra thick max density w900 value
                    letterSpacing: 4.0, // Stretches out the horizontal tracking width across character elements by four pixels for tech brand feel
                  ),
                ),
                Text(
                  'THE ULTIMATE CHASE', // Injects the gaming subtitle branding phrase string literal into the drawing flow
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55), // Elevates the tagline opacity to fifty-five percent white to stand out proudly against the blue
                    fontSize: 12, // Restricts the gaming tagline layout width print footprint strictly to twelve logical points
                    fontWeight: FontWeight.w700, // Thickens the typeface characters to a solid w700 bold configuration weight profile
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
                  accentColor: const Color(0xFF4FA3FF), // Upgrades the versus accent color path to a blazing neon electric sky blue layout tone
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
                    color: Colors.white.withValues(alpha: 0.35), // Raises the footer visibility layout footprint smoothly to thirty-five percent alpha tint
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