import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TailorServicesManagerScreen extends StatefulWidget {
  const TailorServicesManagerScreen({super.key});

  @override
  State<TailorServicesManagerScreen> createState() =>
      _TailorServicesManagerScreenState();
}

class _TailorServicesManagerScreenState
    extends State<TailorServicesManagerScreen> {
  final List<Map<String, dynamic>> _services = [
    {'id': 'SRV-1', 'name': 'Formal Suit (Custom)', 'price': 1500},
    {'id': 'SRV-2', 'name': 'Pants Alteration', 'price': 100},
    {'id': 'SRV-3', 'name': 'Dress Hemming', 'price': 150},
    {'id': 'SRV-4', 'name': 'Jacket Repair', 'price': 200},
  ];

  void _showServiceModal({DocumentSnapshot? existingService}) {
    final bool isEditing = existingService != null;

    final TextEditingController nameController = TextEditingController(
      text: isEditing ? existingService['name'] : '',
    );
    final TextEditingController priceController = TextEditingController(
      text: isEditing ? existingService['price'].toString() : '',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24, right: 24, top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEditing ? 'تعديل الخدمة' : 'إضافة خدمة جديدة',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: nameController,
                labelText: 'اسم الخدمة (مثال: تقصير بنطلون)',
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                labelText: 'السعر (جنيه)',
              ),
              const SizedBox(height: 24),
              AppButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  final price = int.tryParse(priceController.text.trim()) ?? 0;

                  if (name.isNotEmpty && price > 0) {
                    final String uid = FirebaseAuth.instance.currentUser!.uid;
                    final servicesRef = FirebaseFirestore.instance
                        .collection('Users')
                        .doc(uid)
                        .collection('services'); // دي الكولكشن الفرعية

                    if (isEditing) {
                      // لو بنعدل خدمة موجودة
                      await servicesRef.doc(existingService.id).update({
                        'name': name,
                        'price': price,
                      });
                    } else {
                      // لو بنضيف خدمة جديدة
                      await servicesRef.add({
                        'name': name,
                        'price': price,
                        'createdAt': FieldValue.serverTimestamp(),
                      });
                    }
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                text: isEditing ? 'حفظ التعديلات' : 'إضافة الخدمة',
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteService(String docId, String serviceName) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    // مسح الخدمة من الداتابيز
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('services')
        .doc(docId)
        .delete();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم حذف $serviceName.'),
        backgroundColor: AppColors.statusClosed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: const Text('Services & Pricing'),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
      ),
// استبدل الـ body الحالي بالبلوك ده
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('services')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState();
          }

          final services = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final serviceDoc = services[index];
              return _buildServiceCard(serviceDoc);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showServiceModal(),
        backgroundColor: AppColors.accentGold,
        icon: const Icon(Icons.add, color: AppColors.primaryNavy),
        label: const Text(
          'Add Service',
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: AppColors.textLight,
          ),
          SizedBox(height: 16),
          Text(
            'No services yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textMedium,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the button below to add your first service.',
            style: TextStyle(fontSize: 14, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }
  Widget _buildServiceCard(DocumentSnapshot serviceDoc) { // 1. تعديل نوع الباراميتر هنا
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: AppColors.backgroundWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryNavy.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.cut_rounded,
                color: AppColors.primaryNavy,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceDoc['name'], // 2. قراءة الاسم من الدوكيومنت
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${serviceDoc['price']} EGP', // 3. قراءة السعر من الدوكيومنت
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentGold,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit_rounded,
                    color: AppColors.primaryNavy,
                  ),
                  // 4. إرسال الدوكيومنت لدالة التعديل
                  onPressed: () => _showServiceModal(existingService: serviceDoc),
                  tooltip: 'Edit Price',
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.statusClosed,
                  ),
                  // 5. إرسال الـ ID والاسم لدالة الحذف عشان الإيرور يختفي
                  onPressed: () => _deleteService(serviceDoc.id, serviceDoc['name']),
                  tooltip: 'Delete Service',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
