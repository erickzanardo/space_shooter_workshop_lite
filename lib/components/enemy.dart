import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/palette.dart';
import 'package:space_shooter_workshop/game.dart';

class Enemy extends RectangleComponent with HasGameRef<SpaceShooterGame> {
  Enemy({
    super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(16),
          paint: BasicPalette.pink.paint(),
          children: [
            RectangleHitbox(
              size: Vector2.all(16),
            ),
          ],
        );

  static const _speed = 50.0;

  @override
  void update(double dt) {
    super.update(dt);

    position.y += _speed * dt;

    if (position.y >= SpaceShooterGame.resolution.y + size.y) {
      removeFromParent();
    }
  }
}

class EnemySpawner extends SpawnComponent {
  EnemySpawner()
      : super(
          period: 1,
          factory: (_) => Enemy(),
          area: Rectangle.fromLTWH(
            -SpaceShooterGame.resolution.x / 2,
            -SpaceShooterGame.resolution.y / 2 - 16,
            SpaceShooterGame.resolution.x,
            0,
          ),
        );
}
