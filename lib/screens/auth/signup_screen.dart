import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _signup() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement actual Firebase auth registration
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully! Please login.')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(Icons.school, size: 64, color: AppColors.primary),
                ),
                const SizedBox(height: 32),
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Fill in your details to register',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: _nameController,
                  hintText: 'Full Name',
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (val) => val == null || val.isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _emailController,
                  hintText: 'Email or Phone',
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (val) => val == null || val.isEmpty ? 'Email is required' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPassword: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (val) => val == null || val.isEmpty ? 'Password is required' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  isPassword: _obscureConfirmPassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Confirm password is required';
                    if (val != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: 'Sign Up',
                  onPressed: _signup,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?', style: TextStyle(color: AppColors.textSecondary)),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Login', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
