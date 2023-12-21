
import 'package:ralert/core/tools/vector.dart';

class MotionEntity {
  final DateTime dateTime;
  final Location ? location;
  final Vector2D ? acceleration;
  final Vector2D ? speed;

  MotionEntity({
    required this.dateTime,
    this.location,
    this.acceleration,
    this.speed
  });

  @override
  String toString() {
    String acc = acceleration != null ? " A(${acceleration!.x}, ${acceleration!.y})" : "";
    String loc = location != null ? " L(${location!.longitude}, ${location!.latitude})" : "";
    
    return "[$dateTime]$acc$loc";
  }
}