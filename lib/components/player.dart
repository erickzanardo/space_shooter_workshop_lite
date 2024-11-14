import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_shooter_workshop/components/components.dart';
import 'package:space_shooter_workshop/components/explosion.dart';
import 'package:space_shooter_workshop/components/shield_counter.dart';
import 'package:space_shooter_workshop/game/game.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  Player({
    super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(48),
          children: [
            RectangleHitbox(
              size: Vector2.all(48),
            ),
          ],
        );

  static const _speed = 100.0;
  final _direction = Vector2.zero();

  int _shield = 3;

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'starfighter_2.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2.all(48),
      ),
    );

    add(
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.keyA: (_) {
            if (_direction.x == -1) {
              _direction.x = 0;
            }
            return false;
          },
          LogicalKeyboardKey.keyD: (_) {
            if (_direction.x == 1) {
              _direction.x = 0;
            }
            return false;
          },
          LogicalKeyboardKey.keyW: (_) {
            if (_direction.y == -1) {
              _direction.y = 0;
            }
            return false;
          },
          LogicalKeyboardKey.keyS: (_) {
            if (_direction.y == 1) {
              _direction.y = 0;
            }
            return false;
          },
          LogicalKeyboardKey.space: (_) {
            _shoot();
            return false;
          },
        },
        keyDown: {
          LogicalKeyboardKey.keyA: (_) {
            _direction.x = -1;
            return false;
          },
          LogicalKeyboardKey.keyD: (_) {
            _direction.x = 1;
            return false;
          },
          LogicalKeyboardKey.keyW: (_) {
            _direction.y = -1;
            return false;
          },
          LogicalKeyboardKey.keyS: (_) {
            _direction.y = 1;
            return false;
          },
          LogicalKeyboardKey.space: (_) => false,
        },
      ),
    );
  }

  void _shoot() {
    gameRef.world.add(
      Shoot(
        position: position.clone() -
            Vector2(
              0,
              size.y / 2,
            ),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _direction * _speed * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      gameRef.world.add(Explosion(position: other.position));
      other.removeFromParent();

      if (_shield == 0) {
        removeFromParent();
        gameRef.world.add(
          TextComponent(
            priority: 100,
            position: Vector2(-48, -2),
            text: 'Game Over',
            textRenderer: TextPaint(
              style: GoogleFonts.pressStart2p(
                color: const Color(0xFFA2FFF3),
                fontSize: 12,
              ),
            ),
          ),
        );
        gameRef.world.add(
          TextComponent(
            priority: 100,
            position: Vector2(-92, 12),
            text: 'Refresh the page to play again',
            textRenderer: TextPaint(
              style: GoogleFonts.pressStart2p(
                color: const Color(0xFFA2FFF3),
                fontSize: 6,
              ),
            ),
          ),
        );
      } else {
        _shield--;
        gameRef.world.firstChild<ShieldCounter>()?.removeShield();
      }
    }
  }
}
