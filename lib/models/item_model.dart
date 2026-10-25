
class ItemModel {
  final String id;
  final String name;
  final String description;
  final String location;
  final String date;
  final String type;
  final String reporterName;
  final String reporterPhone;

  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.date,
    required this.type,
    this.reporterName = '',
    this.reporterPhone = '',
  });
}
