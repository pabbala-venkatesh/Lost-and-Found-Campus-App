
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';
import '../services/firebase_service.dart';
import '../models/item_model.dart';
import 'report_item_page.dart';
import 'lost_items_page.dart';
import 'found_items_page.dart';
import 'item_details_page.dart';

const Color navyBlue = Color(0xFF12316E);
const Color primaryBlue = Color(0xFF2563EB);
const Color lightBlue = Color(0xFFEAF2FF);
const Color pageBackground = Color(0xFFF6F8FC);
const Color textDark = Color(0xFF172B4D);
const Color textMuted = Color(0xFF667085);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController =
      TextEditingController();

  final AuthService _authService = AuthService();
  final FirebaseService _firebaseService = FirebaseService();

  String searchQuery = '';
  List<ItemModel> firestoreItems = [];
  bool isLoadingItems = true;
  String? itemsError;

  StreamSubscription<List<Map<String, dynamic>>>? _itemsSubscription;

  @override
  void initState() {
    super.initState();
    _listenToFirestoreItems();
  }

  void _listenToFirestoreItems() {
    _itemsSubscription = _firebaseService.getItemsStream().listen(
      (data) {
        if (!mounted) return;

        final items = data.map((item) {
          return ItemModel(
            id: (item['id'] ?? '').toString(),
            name: (item['name'] ?? 'Unnamed item').toString(),
            description: (item['description'] ?? '').toString(),
            location: (item['location'] ?? '').toString(),
            date: (item['date'] ?? '').toString(),
            type: (item['type'] ?? '').toString(),
            reporterName: (item['reporterName'] ?? '').toString(),
            reporterPhone: (item['reporterPhone'] ?? '').toString(),
            ownerUid: (item['ownerUid'] ?? '').toString(),
          );
        }).toList();

        setState(() {
          firestoreItems = items;
          isLoadingItems = false;
          itemsError = null;
        });
      },
      onError: (Object error) {
        if (!mounted) return;

        setState(() {
          isLoadingItems = false;
          itemsError = error.toString();
        });
      },
    );
  }

  @override
  void dispose() {
    _itemsSubscription?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Future<void> signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();

      if (!mounted) return;

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google sign-in successful!'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign-in failed: ${e.message ?? e.code}'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed: $e')),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();

      if (!mounted) return;

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed out successfully')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-out failed: $e')),
      );
    }
  }

  List<ItemModel> get searchResults {
    final query = searchQuery.trim().toLowerCase();

    if (query.isEmpty) return [];

    return firestoreItems.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.location.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query) ||
          item.type.toLowerCase().contains(query);
    }).toList();
  }

  void openItem(ItemModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ItemDetailsPage(item: item),
      ),
    );
  }

  Future<void> openReportPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ReportItemPage(),
      ),
    );
  }

  Future<void> openListPage(Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Widget buildCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFE6EAF2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: color, size: 26),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Explore',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: color,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItemCard(ItemModel item) {
    final isLost = item.type.toLowerCase() == 'lost';
    final statusColor = isLost
        ? const Color(0xFFD94841)
        : const Color(0xFF16865C);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE9EDF4)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => openItem(item),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: isLost
                      ? const Color(0xFFFFF0EE)
                      : const Color(0xFFE7F7EF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  isLost
                      ? Icons.search_rounded
                      : Icons.inventory_2_outlined,
                  color: statusColor,
                  size: 26,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: textMuted,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            item.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.type,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: textMuted,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAccountAction() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: TextButton.icon(
          onPressed: signInWithGoogle,
          icon: const Icon(Icons.login_rounded),
          label: const Text('Sign in'),
        ),
      );
    }

    return PopupMenuButton<String>(
      tooltip: 'Account',
      onSelected: (value) {
        if (value == 'signout') {
          signOut();
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'signout',
          child: Row(
            children: [
              Icon(Icons.logout_rounded),
              SizedBox(width: 10),
              Text('Sign out'),
            ],
          ),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CircleAvatar(
          radius: 17,
          backgroundColor: lightBlue,
          backgroundImage:
              user.photoURL != null ? NetworkImage(user.photoURL!) : null,
          child: user.photoURL == null
              ? const Icon(
                  Icons.account_circle_rounded,
                  color: primaryBlue,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = searchResults;
    final isSearching = searchQuery.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: navyBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.school_rounded,
                color: Colors.white,
                size: 23,
              ),
            ),
            const SizedBox(width: 11),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Campus',
                    style: TextStyle(
                      color: navyBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'LOST & FOUND',
                    style: TextStyle(
                      color: textMuted,
                      fontSize: 10,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [buildAccountAction()],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = constraints.maxWidth > 1000
                ? 1000.0
                : constraints.maxWidth;

            return Center(
              child: SizedBox(
                width: contentWidth,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF12316E),
                              Color(0xFF2563EB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -12,
                              top: 5,
                              child: Icon(
                                Icons.travel_explore_rounded,
                                size: 112,
                                color: Colors.white.withValues(alpha: 0.10),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 11,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(
                                      alpha: 0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Text(
                                    'YOUR CAMPUS, CONNECTED',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      letterSpacing: 1.1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                const Text(
                                  'Lost something?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    height: 1.2,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Let’s help you find it.',
                                  style: TextStyle(
                                    color: Color(0xFFDCE8FF),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Search campus reports or help someone '
                                  'reunite with a lost belonging.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Find an item',
                        style: TextStyle(
                          color: textDark,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() => searchQuery = value);
                        },
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: 'Search name, location or description',
                          hintStyle: const TextStyle(
                            color: textMuted,
                            fontSize: 13,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: primaryBlue,
                          ),
                          suffixIcon: searchQuery.isNotEmpty
                              ? IconButton(
                                  tooltip: 'Clear search',
                                  icon: const Icon(Icons.close_rounded),
                                  onPressed: () {
                                    searchController.clear();
                                    setState(() => searchQuery = '');
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 17,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFE3E8F0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFE3E8F0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: primaryBlue,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (!isSearching) ...[
                        const Text(
                          'Explore categories',
                          style: TextStyle(
                            color: textDark,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildCategoryCard(
                              title: 'Lost Items',
                              subtitle: 'Find missing belongings',
                              icon: Icons.search_rounded,
                              color: primaryBlue,
                              onTap: () => openListPage(
                                const LostItemsPage(),
                              ),
                            ),
                            const SizedBox(width: 14),
                            buildCategoryCard(
                              title: 'Found Items',
                              subtitle: 'See items turned in',
                              icon: Icons.inventory_2_outlined,
                              color: const Color(0xFF16865C),
                              onTap: () => openListPage(
                                const FoundItemsPage(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                      ],
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              isSearching ? 'Search results' : 'Recent reports',
                              style: const TextStyle(
                                color: textDark,
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text(
                            isSearching
                                ? '${results.length} found'
                                : '${firestoreItems.length} reports',
                            style: const TextStyle(
                              color: textMuted,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (isLoadingItems)
                        const Padding(
                          padding: EdgeInsets.all(30),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: primaryBlue,
                            ),
                          ),
                        )
                      else if (itemsError != null)
                        buildEmptyState(
                          icon: Icons.cloud_off_outlined,
                          title: 'Unable to load reports',
                          message:
                              'Check your internet connection and Firestore rules.',
                        )
                      else if (isSearching && results.isEmpty)
                        buildEmptyState(
                          icon: Icons.search_off_rounded,
                          title: 'No matching items',
                          message:
                              'Try another name, location or keyword.',
                        )
                      else if (!isSearching && firestoreItems.isEmpty)
                        buildEmptyState(
                          icon: Icons.inventory_2_outlined,
                          title: 'No reports yet',
                          message:
                              'Be the first to report a lost or found item.',
                        )
                      else
                        ...(isSearching
                                ? results
                                : firestoreItems.reversed.take(8).toList())
                            .map(buildItemCard),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openReportPage,
        backgroundColor: navyBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Report Item',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE9EDF4)),
      ),
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: primaryBlue, size: 29),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: textDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: textMuted,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
