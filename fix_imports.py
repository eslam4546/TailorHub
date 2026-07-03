import os

for root, dirs, files in os.walk("lib"):
    for file in files:
        if file.endswith(".dart"):
            path = os.path.join(root, file)
            with open(path, "r", encoding="utf-8") as f:
                content = f.read()
            
            if "import 'package:flutter_gen/gen_l10n/app_localizations.dart';" in content:
                content = content.replace("import 'package:flutter_gen/gen_l10n/app_localizations.dart';", "import 'package:tailor_shop/l10n/app_localizations.dart';")
                with open(path, "w", encoding="utf-8") as f:
                    f.write(content)
print("Imports fixed.")
