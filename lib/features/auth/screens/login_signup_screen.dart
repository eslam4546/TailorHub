import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../customer/screens/customer_main_layout.dart';
import '../../tailor/screens/tailor_dashboard_screen.dart';
import 'package:tailor_shop/l10n/app_localizations.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool _isLogin = true;

  bool _isCustomer = true;

  bool _showPassword = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_isCustomer) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CustomerMainLayout()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TailorDashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              _buildHeader(),

              const SizedBox(height: 32),

              _buildAuthToggle(),

              const SizedBox(height: 24),

              _buildRoleSelector(),

              const SizedBox(height: 28),

              _buildFormFields(),

              const SizedBox(height: 32),

              _buildSubmitButton(),

              const SizedBox(height: 20),

              _buildTogglePrompt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(Icons.content_cut_rounded, size: 48, color: AppColors.accentGold),
        const SizedBox(height: 12),
        const Text(
          'TailorHub',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _isLogin
              ? AppLocalizations.of(context)!.welcomeBack
              : AppLocalizations.of(context)!.createAccount,
          style: const TextStyle(fontSize: 15, color: AppColors.textMedium),
        ),
      ],
    );
  }

  Widget _buildAuthToggle() {
    return SegmentedButton<bool>(
      selected: {_isLogin},

      onSelectionChanged: (Set<bool> newSelection) {
        setState(() {
          _isLogin = newSelection.first;
        });
      },

      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryNavy;
          }
          return Colors.transparent;
        }),

        foregroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.textWhite;
          }
          return AppColors.primaryNavy;
        }),

        iconColor: WidgetStateProperty.all(Colors.transparent),
        iconSize: WidgetStateProperty.all(0),
        side: WidgetStateProperty.all(
          const BorderSide(color: AppColors.primaryNavy),
        ),
      ),

      segments: [
        ButtonSegment<bool>(
          value: true,
          label: Text(AppLocalizations.of(context)!.login),
          icon: const Icon(Icons.login_rounded),
        ),
        ButtonSegment<bool>(
          value: false,
          label: Text(AppLocalizations.of(context)!.signUp),
          icon: const Icon(Icons.person_add_rounded),
        ),
      ],
    );
  }

  Widget _buildRoleSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.iAmA,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: _RoleTile(
                icon: Icons.shopping_bag_rounded,
                label: AppLocalizations.of(context)!.customer,
                isSelected: _isCustomer,
                onTap: () => setState(() => _isCustomer = true),
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: _RoleTile(
                icon: Icons.content_cut_rounded,
                label: AppLocalizations.of(context)!.tailorRole,
                isSelected: !_isCustomer,
                onTap: () => setState(() => _isCustomer = false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isLogin
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.fullName,
                      hintText: AppLocalizations.of(context)!.enterFullName,
                      prefixIcon: const Icon(Icons.person_outlined),
                    ),
                  ),
                ),
        ),

        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.email,
            hintText: AppLocalizations.of(context)!.enterEmail,
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),

        const SizedBox(height: 16),

        TextField(
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
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
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
    );
  }

  Widget _buildTogglePrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isLogin
              ? AppLocalizations.of(context)!.dontHaveAccount
              : AppLocalizations.of(context)!.alreadyHaveAccount,
          style: const TextStyle(color: AppColors.textMedium, fontSize: 14),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isLogin = !_isLogin;
            });
          },
          child: Text(
            _isLogin
                ? AppLocalizations.of(context)!.signUp
                : AppLocalizations.of(context)!.login,
            style: const TextStyle(
              color: AppColors.accentGold,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _RoleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleTile({
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
        padding: const EdgeInsets.symmetric(vertical: 16),
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
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.textWhite : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
