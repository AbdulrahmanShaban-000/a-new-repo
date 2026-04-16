import 'package:college_project/Provider/AuthProvider.dart';
import 'package:college_project/Screens/apartments.dart';
import 'package:college_project/login/Regester.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key});

  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade600],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [ 
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  children: [
                    /// Header
                    const Text(
                      "Let's Sign you in 👋",
                      style: TextStyle(
                        fontSize: 42, // ⬆ أكبر
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      "Welcome back, we missed you",
                      style: TextStyle(
                        fontSize: 24, // ⬆ أكبر
                        color: Colors.white70,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 45),

                    /// Card Form
                    Container(
                      padding: const EdgeInsets.all(24),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 25,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            /// Email
                            TextFormField(
                              controller: Loginscreen.emailController,
                              style: const TextStyle(fontSize: 18),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? 'Email is required'
                                  : null,
                              decoration: InputDecoration(
                                hintText: "Number",
                                hintStyle: const TextStyle(fontSize: 16),
                                prefixIcon: const Icon(Icons.phone, size: 26),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 22),

                            /// Password
                            TextFormField(
                              controller: Loginscreen.passwordController,
                              obscureText: isPasswordVisible, 
                              style: const TextStyle(fontSize: 18),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? 'Password is required'
                                  : null,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: const TextStyle(fontSize: 16),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  size: 26,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// Error Message
                            if (authProvider.errorMessage != null)
                              Text(
                                authProvider.errorMessage!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Register
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).push(MaterialPageRoute(builder: (_) => Regester()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18, // ⬆ أكبر
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " Register !",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22, // ⬆ أكبر
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

          
              Container(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,  
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await context
                                  .read<AuthProvider>()
                                  .login(
                                    Loginscreen.emailController.text,
                                    Loginscreen.passwordController.text,
                                  );

                            
                              if (result != null &&
                                  result['success'] &&
                                  context.mounted) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        Apartments(role: result['role']),
                                  ),
                                );
                              }
                            }
                          },
                    child: authProvider.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
