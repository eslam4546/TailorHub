import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:tailor_shop/l10n/app_localizations.dart';
import 'regular_booking_screen.dart';
import 'vip_booking_screen.dart';
class TailorProfileScreen extends StatelessWidget {
final Map<String, dynamic> tailorData;
final String tailorUid;

const TailorProfileScreen({
super.key,
required this.tailorData,
required this.tailorUid,
});

static const int _totalReviews = 124;
static const String _bio =
'Master tailor with 15+ years of experience in premium '
'men\'s fashion. Specializing in bespoke suits, formal '
'shirts, and traditional galabiyas. Known for precise '
'measurements and fast turnaround.';

static const List<Map<String, dynamic>> _reviews = [
{
'name': 'Mohamed Ali',
'rating': 5,
'comment': 'Excellent work on my wedding suit! Perfect fit.',
'date': '2 days ago',
},
{
'name': 'Kareem Hassan',
'rating': 4,
'comment': 'Great alterations, very reasonable prices.',
'date': '1 week ago',
},
{
'name': 'Omar Youssef',
'rating': 5,
'comment': 'Fast and professional. Highly recommended!',
'date': '2 weeks ago',
},
];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,

      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tailor),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 16),
            _buildAboutSection(context),
            SizedBox(height: 16),
            _buildPricingMatrix(context),
            SizedBox(height: 16),
            _buildReviewsSection(context),
          ],
        ),
      ),

      bottomNavigationBar: _buildFooterButtons(context),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryNavy,
              border: Border.all(color: AppColors.accentGold, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentGold.withValues(alpha: 0.3),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                tailorData['name'] != null ? tailorData['name'][0].toUpperCase() : 'T',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentGold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            tailorData['name'] ?? 'خياط غير مسمى',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tailorData['specialty'] ?? 'Unisex',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textWhite.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoChip(
                icon: Icons.star_rounded,
                label: '${tailorData['rating'] ?? 5.0} ($_totalReviews)',
                iconColor: AppColors.accentGold,
              ),
              const SizedBox(width: 12),
              _buildInfoChip(
                icon: Icons.location_on_rounded,
                label: tailorData['distance'] ?? '1.0 km',
                iconColor: AppColors.textWhite,
              ),
              const SizedBox(width: 12),
              _buildStatusChip(),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color iconColor,
  }) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.textWhite.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textWhite.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    final Color statusColor;
    final String statusLabel;

    final currentStatus = tailorData['status'] ?? 'Available';

    switch (currentStatus) {
      case 'Available':
        statusColor = AppColors.statusAvailable;
        statusLabel = 'متاح';
        break;
      case 'Busy':
        statusColor = AppColors.statusBusy;
        statusLabel = 'مزدحم';
        break;
      default:
        statusColor = AppColors.statusClosed;
        statusLabel = 'مغلق';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            statusLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildAboutSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                  color: AppColors.primaryNavy,
                ),
                SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.about,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            const Text(
              _bio,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textMedium,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingMatrix(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.receipt_long_rounded,
                  size: 20,
                  color: AppColors.primaryNavy,
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.servicesAndPricing,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context)!.allPricesInEgp,
              style: const TextStyle(fontSize: 12, color: AppColors.textLight),
            ),
            const SizedBox(height: 16),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(tailorUid)
                  .collection('services')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('لا توجد خدمات متاحة حالياً', style: TextStyle(color: AppColors.textMedium)),
                  );
                }

                final services = snapshot.data!.docs;

                return Column(
                  children: List.generate(services.length, (index) {
                    final service = services[index];
                    return Column(
                      children: [
                        if (index > 0)
                          const Divider(color: AppColors.dividerGrey, height: 1),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryNavy.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.cut_rounded,
                                  size: 20,
                                  color: AppColors.primaryNavy,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  service['name'],
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textDark,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.accentGold.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${service['price']} EGP',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.accentGold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.rate_review_rounded,
                      size: 20,
                      color: AppColors.primaryNavy,
                    ),
                    SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.customerReviews,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),

                Text(
                  'See all ($_totalReviews)',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentGold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            ...List.generate(_reviews.length, (index) {
              final review = _reviews[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < _reviews.length - 1 ? 12 : 0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            review['name'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                          Text(
                            review['date'] as String,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),

                      Row(
                        children: List.generate(
                          5,
                          (starIndex) => Icon(
                            starIndex < (review['rating'] as int)
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 16,
                            color: starIndex < (review['rating'] as int)
                                ? AppColors.accentGold
                                : AppColors.dividerGrey,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),

                      Text(
                        review['comment'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textMedium,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RegularBookingScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_today_rounded, size: 18),
                label: Text(AppLocalizations.of(context)!.standardBooking),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: AppColors.textWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12),

          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VipBookingScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.home_rounded, size: 18),
                label: Text(AppLocalizations.of(context)!.vipHomeService),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGold,
                  foregroundColor: AppColors.primaryNavy,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
