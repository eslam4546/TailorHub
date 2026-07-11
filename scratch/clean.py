import os

def rm_import(filepath, imp):
    with open(filepath) as f: lines = f.readlines()
    with open(filepath, 'w') as f:
        for line in lines:
            if imp in line: continue
            f.write(line)

rm_import('lib/features/customer/screens/customer_home_screen.dart', "import 'tailor_profile_screen.dart';")
rm_import('lib/features/customer/screens/customer_profile_screen.dart', "import '../../../core/widgets/app_text_field.dart';")
rm_import('lib/features/customer/screens/regular_booking_screen.dart', "import '../../../core/widgets/app_button.dart';")
rm_import('lib/features/onboarding/screens/onboarding_screen.dart', "import '../../../core/widgets/app_text_field.dart';")
rm_import('lib/features/tailor/screens/tailor_order_details_screen.dart', "import '../../../core/widgets/app_text_field.dart';")
rm_import('lib/features/tailor/widgets/order_item_card.dart', "import '../../../core/widgets/app_text_field.dart';")

