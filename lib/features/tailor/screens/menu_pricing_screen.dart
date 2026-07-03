import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';

class MenuPricingScreen extends StatefulWidget {
  const MenuPricingScreen({super.key});

  @override
  State<MenuPricingScreen> createState() => _MenuPricingScreenState();
}

class _MenuPricingScreenState extends State<MenuPricingScreen> {
  final Map<String, List<Map<String, dynamic>>> _groupedServices = {
    'alterations': [
      {'id': 'ALT-1', 'name': 'Pants Hemming', 'price': 35},
      {'id': 'ALT-2', 'name': 'Jacket Sleeve Shortening', 'price': 80},
      {'id': 'ALT-3', 'name': 'Waist Adjustment', 'price': 50},
    ],
    'bespokeCreation': [
      {'id': 'BES-1', 'name': 'Custom Navy Suit', 'price': 2500},
      {'id': 'BES-2', 'name': 'Formal Dress Shirt', 'price': 450},
    ],
    'repairs': [
      {'id': 'REP-1', 'name': 'Zipper Replacement', 'price': 60},
    ],
  };

  void _showAddServiceModal() {}

  void _handleEdit(String serviceName, AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.editingService(serviceName)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleDelete(
    String categoryKey,
    Map<String, dynamic> service,
    AppLocalizations l10n,
  ) {
    setState(() {
      _groupedServices[categoryKey]?.remove(service);
      if (_groupedServices[categoryKey]?.isEmpty ?? false) {
        _groupedServices.remove(categoryKey);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.serviceDeleted(service['name'])),
        backgroundColor: AppColors.statusClosed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: Text(l10n.masterPricing),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text(
                l10n.masterPricingSubtitle,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textMedium,
                  height: 1.4,
                ),
              ),
            ),
          ),

          ..._buildGroupedSlivers(l10n),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddServiceModal,
        backgroundColor: AppColors.accentGold,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add_rounded,
          color: AppColors.primaryNavy,
          size: 28,
        ),
      ),
    );
  }

  List<Widget> _buildGroupedSlivers(AppLocalizations l10n) {
    final List<Widget> slivers = [];

    _groupedServices.forEach((categoryKey, services) {
      if (services.isEmpty) return;

      String displayCategory = categoryKey;
      if (categoryKey == 'alterations') displayCategory = l10n.alterations;
      if (categoryKey == 'bespokeCreation')
        displayCategory = l10n.bespokeCreation;
      if (categoryKey == 'repairs') displayCategory = l10n.repairs;

      slivers.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              displayCategory,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
          ),
        ),
      );

      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final service = services[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildServiceCard(categoryKey, service, l10n),
              );
            }, childCount: services.length),
          ),
        ),
      );
    });

    return slivers;
  }

  Widget _buildServiceCard(
    String categoryKey,
    Map<String, dynamic> service,
    AppLocalizations l10n,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.accentGold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.cut_rounded,
                color: AppColors.accentGold,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${service['price']} EGP',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => _handleEdit(service['name'], l10n),
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: AppColors.textMedium,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => _handleDelete(categoryKey, service, l10n),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      size: 20,
                      color: AppColors.statusClosed.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
