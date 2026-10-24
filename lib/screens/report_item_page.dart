
import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../services/item_store.dart';

const Color _navyBlue = Color(0xFF12316E);
const Color _primaryBlue = Color(0xFF2563EB);
const Color _pageBackground = Color(0xFFF6F8FC);
const Color _textDark = Color(0xFF172B4D);
const Color _textMuted = Color(0xFF667085);

class ReportItemPage extends StatefulWidget {
  const ReportItemPage({super.key});

  @override
  State<ReportItemPage> createState() => _ReportItemPageState();
}

class _ReportItemPageState extends State<ReportItemPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  String itemType = 'Lost';

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void submitReport() {
    if (!_formKey.currentState!.validate()) return;

    final item = ItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      location: locationController.text.trim(),
      date: DateTime.now().toString().split(' ')[0],
      type: itemType,
    );

    ItemStore.items.add(item);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemType item reported successfully!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF16865C),
      ),
    );

    Navigator.pop(context);
  }

  InputDecoration fieldDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: _primaryBlue),
      filled: true,
      fillColor: Colors.white,
      alignLabelWithHint: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE3E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE3E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: _primaryBlue,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  Widget sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        text,
        style: const TextStyle(
          color: _textDark,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLost = itemType == 'Lost';

    return Scaffold(
      backgroundColor: _pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        foregroundColor: _navyBlue,
        title: const Text(
          'Report an Item',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            _navyBlue,
                            _primaryBlue,
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
                            Icons.volunteer_activism_rounded,
                            color: Colors.white,
                            size: 34,
                          ),
                          SizedBox(height: 14),
                          Text(
                            'Help reunite belongings',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Share a few details so your campus '
                            'community can help.',
                            style: TextStyle(
                              color: Color(0xFFDCE8FF),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'Item details',
                      style: TextStyle(
                        color: _textDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Please provide accurate information.',
                      style: TextStyle(
                        color: _textMuted,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 22),

                    sectionLabel('What is the item?'),
                    TextFormField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      maxLength: 80,
                      decoration: fieldDecoration(
                        label: 'Item name',
                        hint: 'e.g. Black wallet, Student ID card',
                        icon: Icons.inventory_2_outlined,
                      ).copyWith(counterText: ''),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the item name.';
                        }
                        if (value.trim().length < 2) {
                          return 'Enter at least 2 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 19),

                    sectionLabel('Describe the item'),
                    TextFormField(
                      controller: descriptionController,
                      textCapitalization: TextCapitalization.sentences,
                      minLines: 3,
                      maxLines: 5,
                      maxLength: 500,
                      decoration: fieldDecoration(
                        label: 'Description',
                        hint: 'Mention its colour, brand or other details',
                        icon: Icons.notes_rounded,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please describe the item.';
                        }
                        if (value.trim().length < 5) {
                          return 'Please add a little more detail.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 19),

                    sectionLabel('Where was it lost or found?'),
                    TextFormField(
                      controller: locationController,
                      textCapitalization: TextCapitalization.words,
                      maxLength: 120,
                      decoration: fieldDecoration(
                        label: 'Campus location',
                        hint: 'e.g. Library, Block A, Canteen',
                        icon: Icons.location_on_outlined,
                      ).copyWith(counterText: ''),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the location.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 19),

                    sectionLabel('Choose a report type'),
                    Row(
                      children: [
                        Expanded(
                          child: _TypeChoiceCard(
                            title: 'Lost item',
                            subtitle: 'Something is missing',
                            icon: Icons.search_rounded,
                            selected: isLost,
                            color: const Color(0xFFD94841),
                            onTap: () {
                              setState(() => itemType = 'Lost');
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _TypeChoiceCard(
                            title: 'Found item',
                            subtitle: 'Something was found',
                            icon: Icons.check_circle_outline_rounded,
                            selected: !isLost,
                            color: const Color(0xFF16865C),
                            onTap: () {
                              setState(() => itemType = 'Found');
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF2FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: _primaryBlue,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'For your safety, avoid including passwords, '
                              'private identification numbers or other '
                              'sensitive personal information.',
                              style: TextStyle(
                                color: _navyBlue,
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed: submitReport,
                        icon: const Icon(Icons.send_rounded),
                        label: const Text(
                          'Submit Report',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _navyBlue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'Please check your details before submitting.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeChoiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _TypeChoiceCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? color.withValues(alpha: 0.07) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? color : const Color(0xFFE3E8F0),
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 23),
                  const Spacer(),
                  Icon(
                    selected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                    color: selected ? color : const Color(0xFF98A2B3),
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: _textDark,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
