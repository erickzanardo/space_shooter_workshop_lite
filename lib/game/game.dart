import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:space_shooter_workshop/components/background.dart';
import 'package:space_shooter_workshop/components/components.dart';
import 'package:space_shooter_workshop/components/score_counter.dart';
import 'package:space_shooter_workshop/components/shield_counter.dart';

class SpaceShooterGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  SpaceShooterGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: resolution.x,
            height: resolution.y,
          ),
        );

  static final resolution = Vector2(384, 320);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    world.addAll([
      RectangleComponent(
        size: resolution,
        position: -resolution / 2,
        paint: BasicPalette.black.paint(),
      ),
      Background(
        position: -resolution / 2,
      ),
      ScoreCounter(
        position: Vector2(
          -resolution.x / 2 + 8,
          -resolution.y / 2 + 8,
        ),
      ),
      ShieldCounter(
        position: Vector2(
          8,
          -resolution.y / 2 + 8,
        ),
      ),
      EnemySpawner(),
      Player(
        position: Vector2(0, resolution.y / 2 - 48),
      ),
    ]);
  }

  @override
  Color backgroundColor() {
    return Colors.grey[900]!;
  }
}
