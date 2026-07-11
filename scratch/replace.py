import os

def rf(filepath, old, new):
    with open(filepath) as f: content = f.read()
    if old in content:
        content = content.replace(old, new)
        # Add imports if changed
        if "import '../../../core/widgets/" not in content and "import '../../core/widgets/" not in content:
            # We need to figure out the depth.
            depth = filepath.count('/') - 2 # e.g. lib/features/auth/screens/foo.dart -> 4 slashes -> depth=2 ... no wait.
            # lib(0)/features(1)/auth(2)/screens(3)/login(4)
            path_parts = filepath.split('/')
            idx_lib = path_parts.index('lib')
            depth = len(path_parts) - idx_lib - 2
            prefix = '../' * depth
            imp = f"import '{prefix}core/widgets/app_button.dart';\nimport '{prefix}core/widgets/app_text_field.dart';\n"
            # find first import
            idx = content.find("import ")
            if idx != -1:
                content = content[:idx] + imp + content[idx:]
        with open(filepath, 'w') as f: f.write(content)

# 1. login_signup_screen.dart
old1_1 = """                  child: TextField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.fullName,
                      hintText: AppLocalizations.of(context)!.enterFullName,
                      prefixIcon: const Icon(Icons.person_outlined),
                    ),
                  ),"""
new1_1 = """                  child: AppTextField(
                    controller: _nameController,
                    labelText: AppLocalizations.of(context)!.fullName,
                    hintText: AppLocalizations.of(context)!.enterFullName,
                    prefixIcon: Icons.person_outlined,
                  ),"""

old1_2 = """        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.email,
            hintText: AppLocalizations.of(context)!.enterEmail,
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),"""
new1_2 = """        AppTextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          labelText: AppLocalizations.of(context)!.email,
          hintText: AppLocalizations.of(context)!.enterEmail,
          prefixIcon: Icons.email_outlined,
        ),"""

old1_3 = """        TextField(
          controller: _passwordController,

          obscureText: !_showPassword,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.password,
            hintText: AppLocalizations.of(context)!.enterPassword,
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
              icon: Icon(
                _showPassword
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: AppColors.textMedium,
              ),
            ),
          ),
        ),"""
new1_3 = """        AppTextField(
          controller: _passwordController,
          obscureText: !_showPassword,
          labelText: AppLocalizations.of(context)!.password,
          hintText: AppLocalizations.of(context)!.enterPassword,
          prefixIcon: Icons.lock_outlined,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
            icon: Icon(
              _showPassword
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              color: AppColors.textMedium,
            ),
          ),
        ),"""

old1_4 = """    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _handleSubmit,
        child: Text(
          _isLogin
              ? AppLocalizations.of(context)!.login
              : AppLocalizations.of(context)!.createAccount,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );"""
new1_4 = """    return AppButton(
      onPressed: _handleSubmit,
      text: _isLogin
          ? AppLocalizations.of(context)!.login
          : AppLocalizations.of(context)!.createAccount,
    );"""

f1 = 'lib/features/auth/screens/login_signup_screen.dart'
rf(f1, old1_1, new1_1)
rf(f1, old1_2, new1_2)
rf(f1, old1_3, new1_3)
rf(f1, old1_4, new1_4)

# 2. customer_home_screen.dart
old2 = """          TextField(
            controller: _searchController,
            style: const TextStyle(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: AppColors.primaryNavy,
            decoration: InputDecoration(
              hintText: l10n.searchHint,
              hintStyle: const TextStyle(
                color: AppColors.textMedium,
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.textMedium,
              ),
              filled: true,
              fillColor: AppColors.backgroundWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),"""
new2 = """          AppTextField(
            controller: _searchController,
            hintText: l10n.searchHint,
            prefixIcon: Icons.search_rounded,
          ),"""
f2 = 'lib/features/customer/screens/customer_home_screen.dart'
rf(f2, old2, new2)

# 3. customer_profile_screen.dart
old3_1 = """            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: const TextStyle(color: AppColors.textMedium),
              ),
            ),"""
new3_1 = """            AppButton(
              onPressed: () => Navigator.of(context).pop(),
              text: AppLocalizations.of(context)!.cancel,
              type: AppButtonType.text,
              isFullWidth: false,
            ),"""

old3_2 = """            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.of(context).pushAndRemoveUntil(
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
              child: Text(AppLocalizations.of(context)!.logOut),
            ),"""
new3_2 = """            AppButton(
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginSignupScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              text: AppLocalizations.of(context)!.logOut,
              isFullWidth: false,
            ),"""
f3 = 'lib/features/customer/screens/customer_profile_screen.dart'
rf(f3, old3_1, new3_1)
rf(f3, old3_2, new3_2)

# 4. regular_booking_screen.dart
old4 = """      child: TextField(
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
      ),"""
new4 = """      child: AppTextField(
        controller: _notesController,
        maxLines: 3,
        hintText: AppLocalizations.of(context)!.specialNotesHint,
      ),"""
f4 = 'lib/features/customer/screens/regular_booking_screen.dart'
rf(f4, old4, new4)
