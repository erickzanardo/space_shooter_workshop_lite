# Space Shooter workshop

<img src="./assets/images/banner.png" alt="Space Shooter Workshop" width="400"/>

This is the repository for the Space Shooter Workshop (lite version).

 - Play the finished game at: https://space-shooter-workshop-lite.pages.dev/
 - The code for the finished game can be found at the `finished_game` branch.
 - The main branch is the starting point for the workshop.

## What to do?

After the workshop live code that got the game to the point that you see here in the main branch
you can continue to add more features to the game!

Here are some ideas and some guidance on how to implement them:

### Change the Enemies and Shoots to have proper sprites

At the starting point, the enemies and shoots are just rectangles. You can change them to have proper sprites.

Use the `Player` component as a reference and checkout in the `assets/images` for the sprites to be used.

### Add a parallax background

Flame provides parallax components, which are great to add to the sense of depth and speed of the game.

The code below shows how to create a parallax component that will fit in the game:

```dart
class Background extends ParallaxComponent<SpaceShooterGame> {
  Background({super.position}) : super(size: SpaceShooterGame.resolution);

  @override
  FutureOr<void> onLoad() async {
    parallax = await game.loadParallax(
      [
        ParallaxImageData('background_stars_1.png'),
        ParallaxImageData('background_stars_2.png'),
        ParallaxImageData('background_stars_3.png'),
      ],
      baseVelocity: Vector2(0, -1),
      velocityMultiplierDelta: Vector2(0, 4.0),
      repeat: ImageRepeat.repeat,
      filterQuality: FilterQuality.none,
    );
  }
}
```

It can then just be added to the game.

### Add explosions

When an enemy is destroyed, you can add an explosion animation to make the game more engaging.

Use what you already know about creating sprite animations and adding components to the game to
implement this feature.

### Make the player collide with the enemies

The player can currently shoot the enemies, but the enemies can't collide with the player. Implement
collision checkings between the player and the enemies, which should destroy the player when they collide.

If you want to make the game more forgiving, implement a shield system that allows the player to take
a few hits before being destroyed.

Check the `ShieldCounter` component in the [finished_game branch](https://github.com/erickzanardo/space_shooter_workshop_lite/blob/finished_game/lib/components/shield_counter.dart) if you need inspiration.

### Make the player shoot more than one bullet at a time

Why not give more firepower to the player? Adjust the current code in order for the player to
shoot additional bullets!

### Add a score system

The game is not very engaging without a score system. Implement a score system that increases
the player's score when they destroy an enemy.

For inspiration, check the `ScoreCounter` component in the [finished game](https://github.com/erickzanardo/space_shooter_workshop_lite/blob/finished_game/lib/components/score_counter.dart).

### Add a game over screen

When the player is destroyed, the game should stop and show a game over screen.
You can check how that is implemented in the [finished game](https://github.com/erickzanardo/space_shooter_workshop_lite/blob/finished_game/lib/components/player.dart#L122) to get some inspiration.
