
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/item_model.dart';
import '../services/firebase_service.dart';

class ItemDetailsPage extends StatefulWidget {
  final ItemModel item;

  const ItemDetailsPage({
    super.key,
    required this.item,
  });

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  bool _busy = false;

  static const navyBlue = Color(0xFF12316E);
  static const primaryBlue = Color(0xFF2563EB);

  Future<void> _contactReporter() async {
    final phone = widget.item.reporterPhone.trim();

    if (phone.isEmpty) {
      _message('The reporter did not provide a contact number.');
      return;
    }

    final uri = Uri(scheme: 'tel', path: phone);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        _message('Could not open the phone dialler on this device.');
      }
    } catch (_) {
      if (mounted) {
        _message(
          'Phone calling may not be supported in this browser. '
          'Try the app on a mobile device.',
        );
      }
    }
  }

  Future<void> _markReturned() async {
    if (_busy) return;

    final currentUser = FirebaseAuth.instance.currentUser;

    // Verify ownership before attempting the update.
    if (currentUser == null ||
        widget.item.ownerUid.isEmpty ||
        currentUser.uid != widget.item.ownerUid) {
      _message('Only the person who submitted this report can mark it as returned.');
      return;
    }

    setState(() => _busy = true);

    try {
      await FirebaseService().markItemReturned(widget.item.id);

      if (!mounted) return;

      _message('Item marked as returned.');
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        _message(e.toString().replaceFirst('Exception: ', ''));
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final currentUser = FirebaseAuth.instance.currentUser;

    final isOwner = currentUser != null &&
        item.ownerUid.isNotEmpty &&
        currentUser.uid == item.ownerUid;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text('Item Details'),
        backgroundColor: Colors.white,
        foregroundColor: navyBlue,
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [navyBlue, primaryBlue],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        item.type.toLowerCase() == 'lost'
                            ? Icons.search
                            : Icons.inventory_2,
                        size: 70,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.type.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _infoCard(
                  Icons.description_outlined,
                  'Description',
                  item.description,
                ),
                _infoCard(
                  Icons.location_on_outlined,
                  'Location',
                  item.location,
                ),
                _infoCard(
                  Icons.calendar_today_outlined,
                  'Date reported',
                  item.date,
                ),
                _infoCard(
                  Icons.person_outline,
                  'Reported by',
                  item.reporterName.isEmpty
                      ? 'Reporter name unavailable for older report'
                      : item.reporterName,
                ),
                const SizedBox(height: 14),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _contactReporter,
                    icon: const Icon(Icons.phone),
                    label: const Text('Contact Reporter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'The reporter’s phone number is not displayed on this page. '
                  'Tapping Contact opens your device’s dialler.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 12,
                  ),
                ),

                if (isOwner) ...[
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _busy ? null : _markReturned,
                      icon: const Icon(Icons.check_circle_outline),
                      label: Text(
                        _busy ? 'Updating…' : 'Mark as Returned',
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mark this report as returned after the item has '
                    'been recovered.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF667085),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF172B4D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
