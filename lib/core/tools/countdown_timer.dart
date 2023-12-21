import 'dart:async';

class CountdownTimer {
  late Timer _timer;
  late int _duration;
  late Function(int) _onTick;
  late Function() _onDone;

  CountdownTimer(this._duration, {required Function(int) onTick, required Function() onDone}) {
    _onTick = onTick;
    _onDone = onDone;
  }

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _tick(Timer timer) {
    if (_duration > 0) {
      _onTick(_duration);
      _duration--;
    } else {
      _timer.cancel(); // Stop the timer
      _onDone();
    }
  }
}