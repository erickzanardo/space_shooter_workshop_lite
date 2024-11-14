import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_shooter_workshop/game/game_page.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  static MaterialPageRoute route() {
    return MaterialPageRoute<void>(
      builder: (_) => const TitleScreen(),
    );
  }

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  late final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (_, __) {
        Navigator.of(context).push(GamePage.route());
        return KeyEventResult.handled;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: Colors.black,
                child: Image.asset(
                  'assets/images/background_stars_1.png',
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.repeat,
                  filterQuality: FilterQuality.none,
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        width: 680,
                        child: Image.asset(
                          'assets/images/banner.png',
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.none,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Press any button to play',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.pressStart2p(
                              fontSize: 16,
                              color: const Color(0xff61d3e3),
                            ),
                          ),
                          Text(
                            'Move with WASD\nShoot with SPACEBAR',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.pressStart2p(
                              fontSize: 12,
                              color: const Color(0xff61d3e3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
