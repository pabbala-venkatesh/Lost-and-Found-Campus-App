import 'package:flutter/material.dart';

class ReportItemPage extends StatefulWidget {
  const ReportItemPage({super.key});

  @override
  State<ReportItemPage> createState() => _ReportItemPageState();
}

class _ReportItemPageState extends State<ReportItemPage> {
  String itemType = 'Lost';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Item Name',
                hintText: 'Example: Black Wallet',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Describe the item',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: 'Example: College Library',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: itemType,
              decoration: InputDecoration(
                labelText: 'Item Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Lost',
                  child: Text('Lost'),
                ),
                DropdownMenuItem(
                  value: 'Found',
                  child: Text('Found'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  itemType = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Submit Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}