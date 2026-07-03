import re

files = [
    "lib/features/customer/screens/tailor_profile_screen.dart",
    "lib/features/customer/screens/regular_booking_screen.dart",
    "lib/features/customer/screens/vip_booking_screen.dart"
]

for f in files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    if "import 'package:flutter_gen/gen_l10n/app_localizations.dart';" not in content:
        content = content.replace(
            "import '../../../core/theme/app_colors.dart';",
            "import '../../../core/theme/app_colors.dart';\nimport 'package:flutter_gen/gen_l10n/app_localizations.dart';"
        )
    
    # Fix tailor_profile_screen specific build methods
    if "tailor_profile" in f:
        content = content.replace("Widget _buildAboutSection() {", "Widget _buildAboutSection(BuildContext context) {")
        content = content.replace("_buildAboutSection(),", "_buildAboutSection(context),")
        
        content = content.replace("Widget _buildPricingMatrix() {", "Widget _buildPricingMatrix(BuildContext context) {")
        content = content.replace("_buildPricingMatrix(),", "_buildPricingMatrix(context),")
        
        content = content.replace("Widget _buildReviewsSection() {", "Widget _buildReviewsSection(BuildContext context) {")
        content = content.replace("_buildReviewsSection(),", "_buildReviewsSection(context),")
    
    # Remove const from structures containing AppLocalizations
    # This is a bit brute force but effective:
    content = content.replace("const Row(", "Row(")
    content = content.replace("const Column(", "Column(")
    content = content.replace("const Padding(", "Padding(")
    content = content.replace("const Center(", "Center(")
    content = content.replace("const Expanded(", "Expanded(")
    content = content.replace("const Container(", "Container(")
    content = content.replace("const SizedBox(", "SizedBox(")
    
    with open(f, 'w', encoding='utf-8') as file:
        file.write(content)

print("Errors fixed.")
