import 'dart:ffi';

class WaterEntry {
  final int? id;
  final DateTime date;
  final int amount;

  WaterEntry({this.id, required this.date, required this.amount});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }

  static WaterEntry fromMap(Map<String, dynamic> map) {
    return WaterEntry(
      id: map['id'],
      date: DateTime.parse(map['date']),
      amount: map['amount'],
    );
  }

  WaterEntry copyWith({
    int? id,
    DateTime? date,
    int? amount,
  }) {
    return WaterEntry(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        date: date ?? this.date
    );
  }
}