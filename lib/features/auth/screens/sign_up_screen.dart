import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/auth/controller/sign_up_controller.dart';
import 'package:batchiq_app/features/auth/screens/sign_in_screen.dart';
import 'package:batchiq_app/features/auth/widgets/auth_divider.dart';
import 'package:batchiq_app/features/auth/widgets/social_button.dart';
import 'package:batchiq_app/features/auth/widgets/auth_footer.dart';
import 'package:batchiq_app/features/batch_management/join_batch/screens/join_batch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _nameTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  "Create an Account",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  "Join us and get started today!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameTEController,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    labelText: "Name",
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex =
                        RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                    if (!emailRegex.hasMatch(email)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.grey.shade600,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: isPasswordVisible
                          ? Icon(Icons.visibility_off, color: Colors.grey.shade600)
                          : Icon(Icons.visibility, color: Colors.grey.shade600),
                    ),
                  ),
                  obscureText: isPasswordVisible ? false : true,
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (password.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: GetBuilder<SignUpController>(
                    builder: (controller) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_globalKey.currentState?.validate() ?? false) {
                            onTapSignUp(
                              _nameTEController.text.trim(),
                              _emailTEController.text.trim(),
                              _passwordTEController.text.trim(),
                            );
                          }
                        },
                        child: Visibility(
                          visible: !controller.isLoading,
                          replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
                          child: const Text(
                            "Create Account",
                            style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }
                  ),
                ),
                const SizedBox(height: 32),
                const AuthDivider(
                  label: 'or sign up with',
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: SocialButton(
                        onTap: () {},
                        imgPath: 'assets/logos/google.png',
                        label: 'Google',
                        context: context,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SocialButton(
                        onTap: () {},
                        imgPath: 'assets/logos/facebook.png',
                        label: 'Facebook',
                        context: context,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                AuthFooter(
                  label: "Already have an account? ",
                  actionText: "Sign In",
                  onTap: () {
                    Get.to(const SignInScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapSignUp(String name, String email, String password) async {
    final controller = SignUpController.instance;
    final isSignUp = await controller.signUp(email: email, password: password, name: name);
    isSignUp
        ? Get.offAll(const JoinBatchScreen())
        : SnackBarMessage.errorMessage(
      controller.errorMessage ?? "Something went wrong!",
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _passwordTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }
}
