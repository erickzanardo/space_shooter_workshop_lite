import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:space_shooter_workshop/components/components.dart';

class SpaceShooterGame extends FlameGame with HasKeyboardHandlerComponents {
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
      EnemySpawner(),
      Player(),
    ]);
  }

  @override
  Color backgroundColor() {
    return Colors.grey[900]!;
  }
}
