import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shooter_workshop/components/components.dart';
import 'package:space_shooter_workshop/components/explosion.dart';
import 'package:space_shooter_workshop/game/game.dart';

class Shoot extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  Shoot({
    super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(16),
          children: [
            RectangleHitbox(
              size: Vector2.all(16),
            ),
          ],
        );

  static const _speed = -400.0;

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'shot_2.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2.all(16),
      ),
    );
  }

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
      gameRef.world.add(Explosion(position: other.position));
    }
  }
}
