import 'dart:convert';

class Source {
  String id;
  String name;
  Source({required this.id, required this.name});

  Source copyWith({String? id, String? name}) {
    return Source(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(id: map['id'] ?? "", name: map['name'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory Source.fromJson(String source) => Source.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Source(id: $id, name: $name)';

  @override
  bool operator ==(covariant Source other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
