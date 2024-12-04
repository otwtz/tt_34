class CurEntry {
  final int? id;
  final String name;
  final double value;

  CurEntry({this.id, required this.name, required this.value});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
    };
  }

  factory CurEntry.fromMap(Map<String, dynamic> map) {
    return CurEntry(
      id: map['id'],
      name: map['name'],
      value: map['value'],
    );
  }
}

class GoalEntry {
  final int? id;
  final String name;
  final double targetWeight;

  GoalEntry({this.id, required this.name, required this.targetWeight});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'targetWeight': targetWeight,
    };
  }

  factory GoalEntry.fromMap(Map<String, dynamic> map) {
    return GoalEntry(
      id: map['id'],
      name: map['name'],
      targetWeight: map['targetWeight'],
    );
  }
}

class StartEntry {
  final int? id;
  final String name;
  final double startWeight;

  StartEntry({this.id, required this.name, required this.startWeight});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'startWeight': startWeight,
    };
  }

  factory StartEntry.fromMap(Map<String, dynamic> map) {
    return StartEntry(
      id: map['id'],
      name: map['name'],
      startWeight: map['startWeight'],
    );
  }
}