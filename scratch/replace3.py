import os

def rf(filepath, old, new):
    if not os.path.exists(filepath): return
    with open(filepath) as f: content = f.read()
    if old in content:
        content = content.replace(old, new)
        # Add imports if changed
        if "import '../../../core/widgets/" not in content and "import '../../core/widgets/" not in content and "import '../../../../core/widgets/" not in content:
            path_parts = filepath.split('/')
            idx_lib = path_parts.index('lib')
            depth = len(path_parts) - idx_lib - 2
            prefix = '../' * depth
            imp = f"import '{prefix}core/widgets/app_button.dart';\nimport '{prefix}core/widgets/app_text_field.dart';\n"
            idx = content.find("import ")
            if idx != -1:
                content = content[:idx] + imp + content[idx:]
        with open(filepath, 'w') as f: f.write(content)


# 6. onboarding_screen.dart
old6_1 = """                    : TextButton(
                        onPressed: _goToLoginSignup,
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.textMedium,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),"""
new6_1 = """                    : AppButton(
                        onPressed: _goToLoginSignup,
                        text: 'Skip',
                        type: AppButtonType.text,
                        isFullWidth: false,
                      ),"""

old6_2 = """                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isLastPage ? _goToLoginSignup : _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryNavy,
                        foregroundColor: AppColors.textWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        isLastPage ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),"""
new6_2 = """                  AppButton(
                    onPressed: isLastPage ? _goToLoginSignup : _nextPage,
                    text: isLastPage ? 'Get Started' : 'Next',
                  ),"""
f6 = 'lib/features/onboarding/screens/onboarding_screen.dart'
rf(f6, old6_1, new6_1)
rf(f6, old6_2, new6_2)

# 7. tailor_earnings_screen.dart
old7_1 = """              TextField(
                controller: serviceController,
                decoration: const InputDecoration(
                  labelText: 'Service Type (e.g. Alteration)',
                  border: OutlineInputBorder(),
                ),
              ),"""
new7_1 = """              AppTextField(
                controller: serviceController,
                labelText: 'Service Type (e.g. Alteration)',
              ),"""

old7_2 = """              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount (EGP)',
                  border: OutlineInputBorder(),
                ),
              ),"""
new7_2 = """              AppTextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                labelText: 'Amount (EGP)',
              ),"""
f7 = 'lib/features/tailor/screens/tailor_earnings_screen.dart'
rf(f7, old7_1, new7_1)
rf(f7, old7_2, new7_2)


old7_3 = """              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final service = serviceController.text.trim();
                    final amount =
                        int.tryParse(amountController.text.trim()) ?? 0;

                    if (service.isNotEmpty && amount > 0) {
                      setState(() {
                        _transactions.insert(0, {
                          'id':
                              'MAN-${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}',
                          'service': service,
                          'date': 'Today',
                          'amount': amount,
                          'status': 'Completed',
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                    foregroundColor: AppColors.textWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Add Transaction'),
                ),
              ),"""
new7_3 = """              AppButton(
                onPressed: () {
                  final service = serviceController.text.trim();
                  final amount =
                      int.tryParse(amountController.text.trim()) ?? 0;

                  if (service.isNotEmpty && amount > 0) {
                    setState(() {
                      _transactions.insert(0, {
                        'id':
                            'MAN-${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}',
                        'service': service,
                        'date': 'Today',
                        'amount': amount,
                        'status': 'Completed',
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                text: 'Add Transaction',
              ),"""
rf(f7, old7_3, new7_3)


# 8. tailor_order_details_screen.dart
old8_1 = """            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _handleAccept,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: AppColors.textWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Accept Order',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),"""
new8_1 = """            child: AppButton(
              onPressed: _handleAccept,
              text: 'Accept Order',
            ),"""
f8 = 'lib/features/tailor/screens/tailor_order_details_screen.dart'
rf(f8, old8_1, new8_1)

# 9. tailor_profile_settings.dart
old9_1 = """            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n.cancel,
                style: const TextStyle(color: AppColors.textMedium),
              ),
            ),"""
new9_1 = """            AppButton(
              onPressed: () => Navigator.pop(context),
              text: l10n.cancel,
              type: AppButtonType.text,
              isFullWidth: false,
            ),"""

old9_2 = """            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginSignupScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.statusClosed,
                foregroundColor: AppColors.textWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(l10n.logOut),
            ),"""
new9_2 = """            AppButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginSignupScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              text: l10n.logOut,
              isFullWidth: false,
            ),"""
f9 = 'lib/features/tailor/screens/tailor_profile_settings.dart'
rf(f9, old9_1, new9_1)
rf(f9, old9_2, new9_2)

# 10. tailor_services_manager_screen.dart
old10_1 = """              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Service Name (e.g. Alteration)',
                  border: OutlineInputBorder(),
                ),
              ),"""
new10_1 = """              AppTextField(
                controller: nameController,
                labelText: 'Service Name (e.g. Alteration)',
              ),"""

old10_2 = """              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Base Price (EGP)',
                  border: OutlineInputBorder(),
                ),
              ),"""
new10_2 = """              AppTextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                labelText: 'Base Price (EGP)',
              ),"""

f10 = 'lib/features/tailor/screens/tailor_services_manager_screen.dart'
rf(f10, old10_1, new10_1)
rf(f10, old10_2, new10_2)

old10_3 = """              SizedBox(
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
                                'SRV-${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}',
                            'name': name,
                            'price': price,
                            'isActive': true,
                          });
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                    foregroundColor: AppColors.textWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(isEditing ? 'Save Changes' : 'Add Service'),
                ),
              ),"""
new10_3 = """              AppButton(
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
                              'SRV-${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}',
                          'name': name,
                          'price': price,
                          'isActive': true,
                        });
                      }
                    });
                    Navigator.pop(context);
                  }
                },
                text: isEditing ? 'Save Changes' : 'Add Service',
              ),"""
rf(f10, old10_3, new10_3)


# 11. order_item_card.dart
old11_1 = """                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: onMarkReady,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNavy,
                      foregroundColor: AppColors.textWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      l10n.markReadyForPickup,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),"""
new11_1 = """                AppButton(
                  onPressed: onMarkReady,
                  text: l10n.markReadyForPickup,
                ),"""
f11 = 'lib/features/tailor/widgets/order_item_card.dart'
rf(f11, old11_1, new11_1)
