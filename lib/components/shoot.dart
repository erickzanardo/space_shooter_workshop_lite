import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:space_shooter_workshop/components/enemy.dart';
import 'package:space_shooter_workshop/game.dart';

class Shoot extends RectangleComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  Shoot({
    super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(16),
          paint: BasicPalette.red.paint(),
          children: [
            RectangleHitbox(
              size: Vector2.all(16),
            ),
          ],
        );

  static const _speed = -400.0;

  @override
  void update(double dt) {
    super.update(dt);

    position.y += _speed * dt;

    if (position.y + size.y < -SpaceShooterGame.resolution.y / 2) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Enemy) {
      other.removeFromParent();
      removeFromParent();
    }
  }
}
