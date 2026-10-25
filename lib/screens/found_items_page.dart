
import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../services/firebase_service.dart';
import 'item_details_page.dart';

class FoundItemsPage extends StatelessWidget {
  const FoundItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        title: const Text(
          'Found Items',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF123B70),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: FirebaseService().getItemsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Unable to load found items. Check your connection '
                      'and Firestore rules.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final foundItems = (snapshot.data ?? [])
                  .where((data) =>
                      (data['type'] ?? '').toString().toLowerCase() ==
                      'found')
                  .map((data) => ItemModel(
                        id: (data['id'] ?? '').toString(),
                        name: (data['name'] ?? 'Unnamed item').toString(),
                        description:
                            (data['description'] ?? '').toString(),
                        location: (data['location'] ?? '').toString(),
                        date: (data['date'] ?? '').toString(),
                        type: (data['type'] ?? 'Found').toString(),
                        reporterName: (data['reporterName'] ?? '').toString(),
                        reporterPhone: (data['reporterPhone'] ?? '').toString(),
                      ))
                  .toList();

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF123B70),
                          Color(0xFF2878D0),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.white,
                          size: 38,
                        ),
                        SizedBox(height: 14),
                        Text(
                          'Found Something?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Browse items found around campus and help '
                          'return them to their owners.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Recently Found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF17365D),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCEBFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${foundItems.length} items',
                          style: const TextStyle(
                            color: Color(0xFF174F91),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (foundItems.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Column(
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 64,
                            color: Color(0xFF8AA4C5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No found items yet',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF17365D),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Found items will appear here after someone '
                            'reports them.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    )
                  else
                    ...foundItems.map((item) {
                      return Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 14),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(
                            color: Color(0xFFE5ECF5),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE4F5EA),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.inventory_2_outlined,
                              color: Color(0xFF218653),
                              size: 28,
                            ),
                          ),
                          title: Text(
                            item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF17365D),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 16,
                                      color: Color(0xFF2878D0),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(child: Text(item.location)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(item.date),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE4F5EA),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'FOUND',
                                    style: TextStyle(
                                      color: Color(0xFF218653),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Color(0xFF2878D0),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ItemDetailsPage(item: item),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
