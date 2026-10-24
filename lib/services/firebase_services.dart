
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference<Map<String, dynamic>> _items =
      FirebaseFirestore.instance.collection('items');

  Future<void> addItem({
    required String name,
    required String description,
    required String location,
    required String date,
    required String type,
  }) async {
    await _items.add({
      'name': name,
      'description': description,
      'location': location,
      'date': date,
      'type': type,
      'status': 'Active',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final snapshot = await _items
        .where('status', isEqualTo: 'Active')
        .get();

    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data(),
      };
    }).toList();
  }
}
