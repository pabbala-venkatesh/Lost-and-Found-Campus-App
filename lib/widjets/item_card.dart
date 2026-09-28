import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String itemName;
  final String location;
  final String date;
  final IconData icon;

  const ItemCard({
    super.key,
    required this.itemName,
    required this.location,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
        ),

        title: Text(
          itemName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          '$location • $date',
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),

        onTap: () {
          // We will connect the details page later.
        },
      ),
    );
  }
}