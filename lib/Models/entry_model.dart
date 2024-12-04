class Entry {
  final int? id;
  final String content;
  final DateTime date;

  Entry({this.id, required this.content, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'date': date.toIso8601String(),
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      id: map['id'],
      content: map['content'],
      date: DateTime.parse(map['date']),
    );
  }

  Entry copyWith({
    int? id,
    String? content,
    DateTime? date,
  }) {
    return Entry(
        id: id ?? this.id,
        content: content ?? this.content,
        date: date ?? this.date
    );
  }
}