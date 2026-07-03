import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

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

  void _showServiceModal({Map<String, dynamic>? existingService}) {
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
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEditing ? 'Edit Service' : 'Add New Service',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Service Name (e.g. Alteration)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Base Price (EGP)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final price =
                        int.tryParse(priceController.text.trim()) ?? 0;

                    if (name.isNotEmpty && price > 0) {
                      setState(() {
                        if (isEditing) {
                          existingService['name'] = name;
                          existingService['price'] = price;
                        } else {
                          _services.add({
                            'id':
                                'SRV-${DateTime.now().millisecondsSinceEpoch}',
                            'name': name,
                            'price': price,
                          });
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                    foregroundColor: AppColors.textWhite,
                  ),
                  child: Text(isEditing ? 'Save Changes' : 'Add Service'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _deleteService(Map<String, dynamic> service) {
    setState(() {
      _services.removeWhere((s) => s['id'] == service['id']);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${service['name']} removed.'),
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
      body: _services.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return _buildServiceCard(service);
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

  Widget _buildServiceCard(Map<String, dynamic> service) {
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
                    service['name'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${service['price']} EGP',
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
                  onPressed: () => _showServiceModal(existingService: service),
                  tooltip: 'Edit Price',
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.statusClosed,
                  ),
                  onPressed: () => _deleteService(service),
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
