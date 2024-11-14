import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_shooter_workshop/game/game.dart';

class ShieldCounter extends PositionComponent
    with HasGameRef<SpaceShooterGame> {
  ShieldCounter({
    super.position,
    this.initialShieldCount = 3,
  }) : super(priority: 20);

  final int initialShieldCount;
  late final TextComponent _text = TextComponent(
    position: Vector2(8, 12),
    text: 'Shield:',
    textRenderer: TextPaint(
      style: GoogleFonts.pressStart2p(
        color: const Color(0xFFA2FFF3),
        fontSize: 10,
      ),
    ),
  );

  int get shieldCount => children.whereType<SpriteComponent>().length;

  void removeShield() {
    if (shieldCount > 0) {
      children.whereType<SpriteComponent>().last.removeFromParent();
    }
  }

  @override
  FutureOr<void> onLoad() async {
    final nineTitleBoxSprite = await gameRef.loadSprite(
      'nine-tile-box.png',
    );

    final energyCell = await gameRef.loadSprite(
      'energy_cell.png',
    );

    add(
      NineTileBoxComponent(
        nineTileBox: NineTileBox(
          nineTitleBoxSprite,
          tileSize: 16,
        ),
        size: Vector2(172, 32),
      ),
    );
    add(_text);

    final initialPosition = Vector2(
      148,
      8,
    );

    for (var i = 0; i < initialShieldCount; i++) {
      add(
        SpriteComponent(
          sprite: energyCell,
          size: Vector2.all(16),
          position: initialPosition - Vector2(22.0 * i, 0),
        ),
      );
    }
  }
}
