import 'package:flutter/material.dart';
import 'package:space_shooter_workshop/tile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MaterialApp(
      home: TitleScreen(),
    ),
  );
}
