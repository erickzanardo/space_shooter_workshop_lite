import 'package:flame/components.dart';
import 'package:space_shooter_workshop/game/game.dart';

class Explosion extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame> {
  Explosion({
    super.position,
  }) : super(
          anchor: Anchor.center,
          removeOnFinish: true,
          size: Vector2.all(32),
        );

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'purple_explosion.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.05,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }
}
