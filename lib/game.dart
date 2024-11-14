import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:space_shooter_workshop/components/components.dart';

class SpaceShooterGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  SpaceShooterGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: resolution.x,
            height: resolution.y,
          ),
        );

  static final resolution = Vector2(256, 240);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    world.addAll([
      RectangleComponent(
        size: resolution,
        position: -resolution / 2,
        paint: BasicPalette.black.paint(),
      ),
      EnemySpawner(),
      Player(),
    ]);
  }

  @override
  Color backgroundColor() {
    return Colors.grey[900]!;
  }
}
