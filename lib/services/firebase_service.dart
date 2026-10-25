
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final CollectionReference<Map<String, dynamic>> _items =
      FirebaseFirestore.instance.collection('items');

  Future<void> addItem({
    required String name,
    required String description,
    required String location,
    required String date,
    required String type,
    required String reporterPhone,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('Please sign in before reporting an item.');
    }

    final reporterName = user.displayName?.trim() ?? '';

    if (reporterName.isEmpty) {
      throw Exception(
        'Your account has no display name. Update your profile first.',
      );
    }

    await _items.add({
      'name': name,
      'description': description,
      'location': location,
      'date': date,
      'type': type,
      'status': 'Active',
      'ownerUid': user.uid,
      'reporterName': reporterName,
      'reporterPhone': reporterPhone.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> markItemReturned(String itemId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Please sign in first.');
    final doc = await _items.doc(itemId).get();
    if (!doc.exists || doc.data()?['ownerUid'] != user.uid) {
      throw Exception('Only the person who reported this item can mark it returned.');
    }
    await _items.doc(itemId).update({'status': 'Returned'});
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final snapshot =
        await _items.where('status', isEqualTo: 'Active').get();

    return snapshot.docs.map((doc) {
      return {'id': doc.id, ...doc.data()};
    }).toList();
  }

  Stream<List<Map<String, dynamic>>> getItemsStream() {
    return _items
        .where('status', isEqualTo: 'Active')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {'id': doc.id, ...doc.data()};
      }).toList();
    });
  }
}
