
import 'package:flutter/material.dart';
import 'package:ralert/config/settings.dart';

class AutomaticCarCrashDetectionWidget extends StatefulWidget {
  const AutomaticCarCrashDetectionWidget({super.key});

  @override
  State<AutomaticCarCrashDetectionWidget> createState() => _AutomaticCarCrashDetectionWidgetState();
}

class _AutomaticCarCrashDetectionWidgetState extends State<AutomaticCarCrashDetectionWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Automatic Car Crash Detection",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
            Switch(
              value: Settings.carCrashDetectionEnabled,
              activeColor: Theme.of(context).colorScheme.secondary,
              onChanged: (bool value) {
                setState(() { Settings.toggleCarCrashDetection(); });
              }
            )
          ],
        )
      ),
    );
  }
}