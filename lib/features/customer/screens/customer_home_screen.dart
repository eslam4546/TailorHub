import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/category_chip.dart';
import '../widgets/tailor_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedCategory = 0;
  final TextEditingController _searchController = TextEditingController();


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
          AppTextField(
            controller: _searchController,
            hintText: l10n.searchHint,
            prefixIcon: Icons.search_rounded,
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
            child: CategoryChip(
              label: categories[index],
              isSelected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = index;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTailorList(AppLocalizations l10n) {
    return StreamBuilder<QuerySnapshot>(
      // عمل Query في الفايربيز لجلب الترزية فقط
      stream: FirebaseFirestore.instance
          .collection('Users')
          .where('role', isEqualTo: 'tailor')
          .snapshots(),
      builder: (context, snapshot) {
        // 1. حالة التحميل (Loading)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: CircularProgressIndicator(),
            ),
          );
        }


        if (snapshot.hasError) {
          return Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
        }

        
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'لا يوجد خياطين متاحين حالياً',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        final tailorDocs = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          itemCount: tailorDocs.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {

            final data = tailorDocs[index].data() as Map<String, dynamic>;


            final tailorMap = {
              'uid': tailorDocs[index].id,
              'name': data['fullName'] ?? 'خياط غير مسمى',
              'rating': 5.0,
              'distance': '1.0 km',
              'specialty': 'Unisex',
              'status': 'Available',
              'services': data['email'] ?? '',
            };

            final bool isAvailable = tailorMap['status'] == 'Available';
            final translatedStatus = _getTranslatedStatus(tailorMap['status'] as String, l10n);
            final translatedSpecialty = _getTranslatedSpecialty(tailorMap['specialty'] as String, l10n);

            return TailorCard(
              tailor: tailorMap,
              translatedStatus: translatedStatus,
              translatedSpecialty: translatedSpecialty,
              isAvailable: isAvailable,
            );
          },
        );
      },
    );
  }
}
