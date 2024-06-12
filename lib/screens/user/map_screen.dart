import 'package:flutter/material.dart';
import 'package:trash_scout/shared/theme/theme.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Text('Map Screen'),
      ),
    );
  }
}
