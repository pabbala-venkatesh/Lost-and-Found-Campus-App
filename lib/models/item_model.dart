
class ItemModel {
  final String id;
  final String name;
  final String description;
  final String location;
  final String date;
  final String type;

  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.date,
    required this.type,
  });

  // Convert an item into a format Firebase can store.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'date': date,
      'type': type,
    };
  }

  // Convert Firebase data back into an ItemModel.
  factory ItemModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return ItemModel(
      id: id,
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
      date: map['date']?.toString() ?? '',
      type: map['type']?.toString() ?? '',
    );
  }
}
