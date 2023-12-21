
/// Collects streamed data anytime and normalizes collected data for each delay
abstract class RecordKeeper<StreamType, Type> {
  final double delay; // in ms
  
  bool hasStarted = false;
  Type marked;
  int markedTime = getMSTime();
  int counter = 1;
  late Type cumulative;
  List<void Function(Type value)> listeners = [];

  RecordKeeper({
    this.delay = 100,
    required Type initial
  }): marked = initial {
    markedTime = getMSTime();
    counter = 1;
    cumulative = this.marked;
  }

  Type add(Type cumulative, Type current);
  Type getAverage(Type cumulative, int counter);
  Type processStreamEvent(StreamType streamEvent);


  void triggerListener() {
    if(this.listeners.isNotEmpty) {
      for (void Function(Type) listener in this.listeners) {
        listener(this.value);
      }
    }
  }
  
  void start(Stream<StreamType> stream) {
    hasStarted = true;
    stream.listen((StreamType streamEvent) {
      record(processStreamEvent(streamEvent));
    });

    triggerListener();
  }


  void addListener(Function(Type value) listener) {
    this.listeners.add(listener);
  }

  void record(Type current) {
    int currentTime = getMSTime();
    cumulative = add(cumulative, current);
    counter++;
    
    if(currentTime - markedTime >= delay) {
      markedTime = currentTime;
      marked = current;
      cumulative = current;
      counter = 1;
    }

    triggerListener();
  }

  Type get value {
    return getAverage(cumulative, counter);
  }
}

int getMSTime() {
  return DateTime.now().millisecondsSinceEpoch;
}