import 'dart:collection';

class Slot {
  int status;
  String start;
  String end;
  Slot({
    this.status,
    this.start,
    this.end,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'start': start,
      'end': end,
    };
  }

  factory Slot.fromMap(LinkedHashMap<String, dynamic> map) {
    if (map == null) return null;

    return Slot(
      status: map['status'],
      start: map['start'],
      end: map['end'],
    );
  }
}
