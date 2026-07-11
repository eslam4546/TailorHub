import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_text_field.dart';
import 'package:tailor_shop/l10n/app_localizations.dart';

class VipBookingScreen extends StatefulWidget {
  const VipBookingScreen({super.key});

  @override
  State<VipBookingScreen> createState() => _VipBookingScreenState();
}

class _VipBookingScreenState extends State<VipBookingScreen> {
  DateTime? _selectedDate;
  int _selectedTimeSlot = -1;
  bool _useCurrentLocation = false;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  static const String _tailorName = 'Ahmed El-Fashionista';

  static const int _baseServiceFee = 300;

  static const int _vipSurcharge = 200;

  static const List<String> _timeSlots = [
    '10:00 AM - 12:00 PM',
    '12:00 PM - 02:00 PM',
    '02:00 PM - 04:00 PM',
    '04:00 PM - 06:00 PM',
    '06:00 PM - 08:00 PM',
  ];

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.accentGold,
              onPrimary: AppColors.primaryNavy,
              surface: AppColors.backgroundWhite,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
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
    return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _toggleCurrentLocation() {
    setState(() {
      _useCurrentLocation = !_useCurrentLocation;
      if (_useCurrentLocation) {
        _addressController.text = '15 El-Tahrir Street, Dokki, Giza, Egypt';
      } else {
        _addressController.clear();
      }
    });
  }

  void _confirmVipBooking() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.vipBookingConfirmed),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.accentGold,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: const Text('VIP Home Service'),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVipBanner(),
            SizedBox(height: 20),
            _buildTailorInfoBar(),
            SizedBox(height: 20),
            _buildAddressSection(),
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

  Widget _buildVipBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentGold.withValues(alpha: 0.15),
            AppColors.accentGoldLight.withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accentGold.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accentGold.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star_rounded,
              color: AppColors.accentGold,
              size: 24,
            ),
          ),
          SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.premiumVipService,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'A professional tailor will visit your home. '
                  'An additional VIP surcharge of 200 EGP applies.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textMedium,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
              border: Border.all(color: AppColors.accentGold, width: 2),
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
                  AppLocalizations.of(context)!.vipHomeVisitRequest,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.accentGold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accentGold,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: AppColors.primaryNavy,
                ),
                SizedBox(width: 4),
                Text(
                  'VIP',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryNavy,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return _VipSectionCard(
      title: AppLocalizations.of(context)!.visitAddress,
      titleIcon: Icons.location_on_rounded,
      child: Column(
        children: [
          AppTextField(
            controller: _addressController,
            hintText: AppLocalizations.of(context)!.enterAddressHint,
            prefixIcon: Icons.home_outlined,
            maxLines: 2,
          ),

          SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _toggleCurrentLocation,
              icon: Icon(
                _useCurrentLocation
                    ? Icons.location_off_rounded
                    : Icons.my_location_rounded,
                size: 18,
              ),
              label: Text(
                _useCurrentLocation
                    ? AppLocalizations.of(context)!.enterAddressManually
                    : AppLocalizations.of(context)!.useCurrentLocation,
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: _useCurrentLocation
                    ? AppColors.textMedium
                    : AppColors.accentGold,
                side: BorderSide(
                  color: _useCurrentLocation
                      ? AppColors.dividerGrey
                      : AppColors.accentGold,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return _VipSectionCard(
      title: AppLocalizations.of(context)!.appointmentDate,
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
                    ? AppColors.accentGold
                    : AppColors.textLight,
                size: 20,
              ),
              SizedBox(width: 12),
              Text(
                _selectedDate != null
                    ? _formatDate(_selectedDate!)
                    : AppLocalizations.of(context)!.tapToSelectAppointmentDate,
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
    return _VipSectionCard(
      title: AppLocalizations.of(context)!.preferredTime,
      titleIcon: Icons.access_time_rounded,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(_timeSlots.length, (index) {
          final bool isSelected = _selectedTimeSlot == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedTimeSlot = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accentGold
                    : AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentGold
                      : AppColors.dividerGrey,
                ),
              ),
              child: Text(
                _timeSlots[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? AppColors.primaryNavy
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
    return _VipSectionCard(
      title: AppLocalizations.of(context)!.measurementNotes,
      titleIcon: Icons.edit_note_rounded,
      child: AppTextField(
        controller: _notesController,
        maxLines: 3,
        hintText: AppLocalizations.of(context)!.measurementNotesHint,
      ),
    );
  }

  Widget _buildOrderSummary() {
    final int total = _baseServiceFee + _vipSurcharge;

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
              Icon(Icons.star_rounded, size: 20, color: AppColors.accentGold),
              SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.vipOrderSummary,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          _summaryRow('Tailor', _tailorName),
          _summaryRow('Service', 'VIP Home Visit'),
          _summaryRow(
            AppLocalizations.of(context)!.address,
            _addressController.text.isNotEmpty
                ? _addressController.text
                : AppLocalizations.of(context)!.notProvided,
          ),
          _summaryRow(
            AppLocalizations.of(context)!.date,
            _selectedDate != null
                ? _formatDate(_selectedDate!)
                : AppLocalizations.of(context)!.notSelected,
          ),
          _summaryRow(
            AppLocalizations.of(context)!.time,
            _selectedTimeSlot >= 0
                ? _timeSlots[_selectedTimeSlot]
                : AppLocalizations.of(context)!.notSelected,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              color: AppColors.textWhite.withValues(alpha: 0.15),
              height: 1,
            ),
          ),

          _pricingRow(
            AppLocalizations.of(context)!.baseServiceFee,
            '$_baseServiceFee EGP',
          ),
          SizedBox(height: 6),
          _pricingRow(
            AppLocalizations.of(context)!.vipSurcharge,
            '$_vipSurcharge EGP',
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.total,
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
                    '$total EGP',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textWhite.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textWhite.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pricingRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textWhite.withValues(alpha: 0.6),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.accentGoldLight,
          ),
        ),
      ],
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
          onPressed: _confirmVipBooking,
          icon: const Icon(Icons.star_rounded, size: 20),
          label: Text(AppLocalizations.of(context)!.confirmVipBooking),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentGold,
            foregroundColor: AppColors.primaryNavy,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _VipSectionCard extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final Widget child;

  const _VipSectionCard({
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
              Icon(titleIcon, size: 18, color: AppColors.accentGold),
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
