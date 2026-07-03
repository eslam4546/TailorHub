import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:tailor_shop/l10n/app_localizations.dart';

class RegularBookingScreen extends StatefulWidget {
  const RegularBookingScreen({super.key});

  @override
  State<RegularBookingScreen> createState() => _RegularBookingScreenState();
}

class _RegularBookingScreenState extends State<RegularBookingScreen> {
  String _serviceType = 'tailoring';

  String? _clothingCategory;

  DateTime? _selectedDate;

  int _selectedTimeSlot = -1;

  final TextEditingController _notesController = TextEditingController();

  static const String _tailorName = 'Ahmed El-Fashionista';

  static const List<String> _clothingCategories = [
    'بنطلون • Pants',
    'قميص • Shirt',
    'بدلة • Suit',
    'جلابية • Galabiya',
    'فستان • Dress',
    'غير ذلك • Other',
  ];

  static const List<String> _timeSlots = [
    '09:00 AM - 11:00 AM',
    '11:00 AM - 01:00 PM',
    '01:00 PM - 03:00 PM',
    '03:00 PM - 05:00 PM',
    '05:00 PM - 07:00 PM',
  ];

  static const Map<String, int> _tailoringPrices = {
    'بنطلون • Pants': 400,
    'قميص • Shirt': 300,
    'بدلة • Suit': 1500,
    'جلابية • Galabiya': 350,
    'فستان • Dress': 500,
    'غير ذلك • Other': 250,
  };

  static const Map<String, int> _repairPrices = {
    'بنطلون • Pants': 50,
    'قميص • Shirt': 80,
    'بدلة • Suit': 150,
    'جلابية • Galabiya': 60,
    'فستان • Dress': 100,
    'غير ذلك • Other': 40,
  };

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  int get _estimatedPrice {
    if (_clothingCategory == null) return 0;
    final prices = _serviceType == 'tailoring'
        ? _tailoringPrices
        : _repairPrices;
    return prices[_clothingCategory] ?? 0;
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,

      initialDate: _selectedDate ?? DateTime.now(),

      firstDate: DateTime.now(),

      lastDate: DateTime.now().add(const Duration(days: 60)),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryNavy,
              onPrimary: AppColors.textWhite,
              surface: AppColors.backgroundWhite,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final dayName = days[date.weekday - 1];
    final monthName = months[date.month - 1];
    return '$dayName, ${date.day} $monthName ${date.year}';
  }

  void _confirmBooking() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.bookingConfirmed),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.statusAvailable,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: const Text('Standard Booking'),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTailorInfoBar(),
            SizedBox(height: 20),

            _buildServiceTypeSection(),
            SizedBox(height: 20),

            _buildClothingDropdown(),
            SizedBox(height: 20),

            _buildDatePicker(),
            SizedBox(height: 20),

            _buildTimeSlotSelector(),
            SizedBox(height: 20),

            _buildNotesField(),
            SizedBox(height: 24),

            _buildOrderSummary(),
          ],
        ),
      ),

      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  Widget _buildTailorInfoBar() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryNavy,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accentGold.withValues(alpha: 0.4),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                'A',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentGold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _tailorName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  AppLocalizations.of(context)!.bookingNewService,
                  style: TextStyle(fontSize: 12, color: AppColors.textMedium),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.statusAvailable.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, size: 7, color: AppColors.statusAvailable),
                SizedBox(width: 5),
                Text(
                  'متاح',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.statusAvailable,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceTypeSection() {
    return _SectionCard(
      title: AppLocalizations.of(context)!.serviceTypeLabel,
      titleIcon: Icons.build_rounded,
      child: Row(
        children: [
          Expanded(
            child: _SelectableCard(
              icon: Icons.content_cut_rounded,
              label: AppLocalizations.of(context)!.tailoringLabel,
              isSelected: _serviceType == 'tailoring',
              onTap: () => setState(() => _serviceType = 'tailoring'),
            ),
          ),
          SizedBox(width: 12),

          Expanded(
            child: _SelectableCard(
              icon: Icons.handyman_rounded,
              label: AppLocalizations.of(context)!.repairLabel,
              isSelected: _serviceType == 'repair',
              onTap: () => setState(() => _serviceType = 'repair'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClothingDropdown() {
    return _SectionCard(
      title: AppLocalizations.of(context)!.clothingType,
      titleIcon: Icons.checkroom_rounded,
      child: DropdownButtonFormField<String>(
        value: _clothingCategory,
        hint: Text(AppLocalizations.of(context)!.selectGarmentHint),
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.dividerGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.primaryNavy,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppColors.backgroundWhite,
        ),
        items: _clothingCategories.map((category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category, style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _clothingCategory = value;
          });
        },
      ),
    );
  }

  Widget _buildDatePicker() {
    return _SectionCard(
      title: AppLocalizations.of(context)!.preferredDate,
      titleIcon: Icons.calendar_today_rounded,
      child: InkWell(
        onTap: _pickDate,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.dividerGrey),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.backgroundWhite,
          ),
          child: Row(
            children: [
              Icon(
                Icons.date_range_rounded,
                color: _selectedDate != null
                    ? AppColors.primaryNavy
                    : AppColors.textLight,
                size: 20,
              ),
              SizedBox(width: 12),
              Text(
                _selectedDate != null
                    ? _formatDate(_selectedDate!)
                    : AppLocalizations.of(context)!.tapToSelectDate,
                style: TextStyle(
                  fontSize: 14,
                  color: _selectedDate != null
                      ? AppColors.textDark
                      : AppColors.textLight,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_drop_down_rounded,
                color: AppColors.textMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlotSelector() {
    return _SectionCard(
      title: AppLocalizations.of(context)!.timeSlot,
      titleIcon: Icons.access_time_rounded,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(_timeSlots.length, (index) {
          final bool isSelected = _selectedTimeSlot == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeSlot = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryNavy
                    : AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryNavy
                      : AppColors.dividerGrey,
                ),
              ),
              child: Text(
                _timeSlots[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? AppColors.textWhite
                      : AppColors.textMedium,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNotesField() {
    return _SectionCard(
      title: AppLocalizations.of(context)!.specialNotes,
      titleIcon: Icons.edit_note_rounded,
      child: TextField(
        controller: _notesController,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.specialNotesHint,
          hintStyle: const TextStyle(fontSize: 13, color: AppColors.textLight),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.dividerGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.primaryNavy,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppColors.backgroundWhite,
          contentPadding: const EdgeInsets.all(14),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_rounded,
                size: 20,
                color: AppColors.accentGold,
              ),
              SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.orderSummary,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          _buildSummaryRow(AppLocalizations.of(context)!.tailor, _tailorName),
          _buildSummaryRow(
            AppLocalizations.of(context)!.service,
            _serviceType == 'tailoring'
                ? 'تفصيل • Tailoring'
                : 'تصليح • Repair',
          ),
          _buildSummaryRow(
            AppLocalizations.of(context)!.garment,
            _clothingCategory ?? AppLocalizations.of(context)!.notSelected,
          ),
          _buildSummaryRow(
            AppLocalizations.of(context)!.date,
            _selectedDate != null
                ? _formatDate(_selectedDate!)
                : AppLocalizations.of(context)!.notSelected,
          ),
          _buildSummaryRow(
            AppLocalizations.of(context)!.time,
            _selectedTimeSlot >= 0
                ? _timeSlots[_selectedTimeSlot]
                : AppLocalizations.of(context)!.notSelected,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              color: AppColors.textWhite.withValues(alpha: 0.2),
              height: 1,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.estimatedTotal,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite.withValues(alpha: 0.8),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentGold,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _estimatedPrice > 0 ? '$_estimatedPrice EGP' : '-- EGP',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textWhite.withValues(alpha: 0.6),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textWhite.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
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
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton.icon(
          onPressed: _confirmBooking,
          icon: const Icon(Icons.check_circle_rounded, size: 20),
          label: Text(AppLocalizations.of(context)!.confirmBooking),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryNavy,
            foregroundColor: AppColors.textWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.titleIcon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(titleIcon, size: 18, color: AppColors.primaryNavy),
              SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),

          child,
        ],
      ),
    );
  }
}

class _SelectableCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryNavy : AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primaryNavy : AppColors.dividerGrey,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? AppColors.accentGold : AppColors.textMedium,
            ),
            SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: isSelected ? AppColors.textWhite : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
