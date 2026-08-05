
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// TODO: fix these two import paths to match where the files actually live in your project
import '../mobile_catalog_screen/mobile_catalog_screen.dart';
import '../setting_screen/setting_screen.dart';
import 'setting_screen.dart';
import 'mobile_catalog_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Available Phones',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // "createdAt" descending shows the newest listing first.
        // Needs createdAt to be saved as a Timestamp/DateTime for sorting to work.
        stream: FirebaseFirestore.instance
            .collection('ProductList')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                'No phones listed yet',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(14),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final docId = docs[index].id;
              return _ProductCard(data: data, docId: docId);
            },
          );
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String docId;

  const _ProductCard({required this.data, required this.docId});

  String _field(String key) {
    final value = data[key];
    if (value == null || value.toString().trim().isEmpty) return '-';
    return value.toString();
  }

  // Condition badge color: green for "New", blue for "Refurbished", orange otherwise (Used, etc.)
  Color _conditionColor() {
    final condition = _field('productCondition').toLowerCase();
    if (condition.contains('new')) return const Color(0xFF1E8E3E);
    if (condition.contains('refurb')) return const Color(0xFF1967D2);
    return const Color(0xFFE8710A);
  }

  // ---------- DELETE ----------
  // Removes this document from Firestore, then navigates to SettingScreen.
  Future<void> _deleteProduct(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('ProductList').doc(docId).delete();

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Listing deleted')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete failed: $e')),
      );
    }
  }

  // ---------- UPDATE ----------
  // Navigates to MobileCatalogScreen so the listing can be edited there.
  // TODO: if you want the form pre-filled, add a constructor param to
  // MobileCatalogScreen (e.g. docId + existingData) and pass them here.
  void _updateProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MobileCatalogScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---------- MAIN CONTENT ----------
            Expanded(child: _buildMainContent()),

            // ---------- SIDE ACTION STRIP: update (green) + delete (red) ----------
            Container(
              width: 52,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.02),
                border: Border(
                  left: BorderSide(color: Colors.black.withOpacity(0.06)),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SideActionButton(
                    icon: Icons.edit,
                    color: const Color(0xFF1E8E3E), // green
                    tooltip: 'Update',
                    onTap: () => _updateProduct(context),
                  ),
                  const SizedBox(height: 14),
                  _SideActionButton(
                    icon: Icons.delete,
                    color: const Color(0xFFD93025), // red
                    tooltip: 'Delete',
                    onTap: () => _deleteProduct(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- TOP ROW: gradient icon badge, name, model, price ----------
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3B2F6B), Colors.black],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.phone_iphone, size: 26, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _field('productName'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 0.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _field('productModel'),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Condition badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _conditionColor().withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _field('productCondition'),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _conditionColor(),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B2F6B), Colors.black],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Rs ${_field('productPrice')}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(height: 1, color: Colors.black.withOpacity(0.06)),

        // ---------- SPEC CHIPS: brand, storage, ram, color ----------
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 4),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoChip(icon: Icons.branding_watermark, label: _field('brand')),
              _InfoChip(icon: Icons.sd_storage, label: _field('storage')),
              _InfoChip(icon: Icons.developer_board, label: _field('ram')),
              _InfoChip(icon: Icons.color_lens_outlined, label: _field('productColor')),
            ],
          ),
        ),

        // ---------- SPECIFICATIONS TEXT ----------
        if (_field('productSpecification') != '-')
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 4),
            child: Text(
              _field('productSpecification'),
              style: TextStyle(
                fontSize: 13,
                color: Colors.black.withOpacity(0.55),
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

        const SizedBox(height: 10),
        Container(height: 1, color: Colors.black.withOpacity(0.06)),

        // ---------- FOOTER: seller avatar, name, location ----------
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.black.withOpacity(0.08),
                child: Text(
                  _field('sellerName') == '-'
                      ? '?'
                      : _field('sellerName')[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _field('sellerName'),
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.location_on_outlined, size: 15, color: Colors.black45),
              const SizedBox(width: 3),
              Text(
                _field('location'),
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Small circular icon button used in the side action strip (update/delete)
class _SideActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _SideActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}

// Small pill/chip used for brand, storage, ram, color
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    if (label == '-') return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF3B2F6B).withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: const Color(0xFF3B2F6B)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}