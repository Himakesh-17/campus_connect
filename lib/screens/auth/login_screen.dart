import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../home/main_shell.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement actual Firebase auth
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainShell()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.white),
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
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to continue',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: _emailController,
                  hintText: 'Email or Phone',
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
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
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?', style: TextStyle(color: AppColors.primary)),
                  ),
                ),
                const SizedBox(height: 16),
                AppButton(
                  text: 'Login',
                  onPressed: _login,
                ),
                const SizedBox(height: 32),
                const Center(
                  child: Text('or continue with', style: TextStyle(color: AppColors.textSecondary)),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(Icons.g_mobiledata, 'Google'), // Using a built-in icon as placeholder for Google
                    const SizedBox(width: 16),
                    _buildSocialButton(Icons.apple, 'Apple'),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: TextStyle(color: AppColors.textSecondary)),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SignupScreen()),
                        );
                      },
                      child: const Text('Sign Up', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
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

  Widget _buildSocialButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 32, color: AppColors.textPrimary),
    );
  }
}
