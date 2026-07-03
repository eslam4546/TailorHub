import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import 'tailor_profile_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedCategory = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _tailors = const [
    {
      'name': 'Ahmed El-Fashionista',
      'rating': 4.8,
      'distance': '1.2 km',
      'specialty': "Men's Wear",
      'status': 'Available',
      'services': 'Suits, Shirts, Alterations',
    },
    {
      'name': 'Fatma\'s Couture',
      'rating': 4.9,
      'distance': '2.5 km',
      'specialty': "Women's Wear",
      'status': 'Busy',
      'services': 'Dresses, Abayas, Formal Gowns',
    },
    {
      'name': 'Hassan Tailor Shop',
      'rating': 4.5,
      'distance': '0.8 km',
      'specialty': 'Unisex',
      'status': 'Available',
      'services': 'Repairs, Alterations, Tailoring',
    },
    {
      'name': 'Nour Premium Tailoring',
      'rating': 5.0,
      'distance': '3.1 km',
      'specialty': "Men's Wear",
      'status': 'Closed',
      'services': 'VIP Home Service, Suits, Galabiyas',
    },
    {
      'name': 'Sara\'s Stitch Studio',
      'rating': 4.7,
      'distance': '1.8 km',
      'specialty': "Women's Wear",
      'status': 'Available',
      'services': 'Bridal, Evening Wear, Repairs',
    },
    {
      'name': 'Mohamed Classic Wear',
      'rating': 4.3,
      'distance': '4.0 km',
      'specialty': "Men's Wear",
      'status': 'Busy',
      'services': 'Pants, Shirts, Galabiyas',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _getTranslatedStatus(String status, AppLocalizations l10n) {
    switch (status) {
      case 'Available':
        return l10n.statusAvailable;
      case 'Busy':
        return l10n.statusBusy;
      case 'Closed':
        return l10n.statusClosed;
      default:
        return status;
    }
  }

  String _getTranslatedSpecialty(String specialty, AppLocalizations l10n) {
    if (specialty == "Men's Wear") return l10n.filterMensWear;
    if (specialty == "Women's Wear") return l10n.filterWomensWear;
    return specialty;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<String> categories = [
      l10n.filterAll,
      l10n.filterMensWear,
      l10n.filterWomensWear,
      l10n.filterVipAccess,
      l10n.filterRepairsOnly,
    ];

    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(l10n),
            _buildCategoryChips(categories),
            Expanded(child: _buildTailorList(l10n)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.welcomeBack,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textWhite.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.findYourTailor,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.textWhite.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.accentGold,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _searchController,
            style: const TextStyle(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: AppColors.primaryNavy,
            decoration: InputDecoration(
              hintText: l10n.searchHint,
              hintStyle: const TextStyle(
                color: AppColors.textMedium,
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.textMedium,
              ),
              filled: true,
              fillColor: AppColors.backgroundWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.accentGold,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(List<String> categories) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(top: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = index;
                });
              },
              selectedColor: AppColors.primaryNavy,
              backgroundColor: AppColors.surfaceGrey,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.textWhite : AppColors.textDark,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primaryNavy
                      : AppColors.dividerGrey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTailorList(AppLocalizations l10n) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      itemCount: _tailors.length,
      itemBuilder: (context, index) {
        final tailor = _tailors[index];
        final bool isAvailable = tailor['status'] == 'Available';
        final translatedStatus = _getTranslatedStatus(tailor['status'], l10n);
        final translatedSpecialty = _getTranslatedSpecialty(
          tailor['specialty'],
          l10n,
        );

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TailorProfileScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryNavy.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.textLight.withValues(alpha: 0.2),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.storefront_rounded,
                      size: 40,
                      color: AppColors.primaryNavy.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              tailor['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryNavy,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppColors.accentGold,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                tailor['rating'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: AppColors.textMedium,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tailor['distance'],
                            style: const TextStyle(
                              color: AppColors.textMedium,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceGrey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              translatedSpecialty,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryNavy,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              tailor['services'],
                              style: const TextStyle(
                                color: AppColors.textMedium,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: isAvailable
                                      ? AppColors.statusAvailable
                                      : AppColors.statusClosed,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                translatedStatus,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isAvailable
                                      ? AppColors.statusAvailable
                                      : AppColors.statusClosed,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
