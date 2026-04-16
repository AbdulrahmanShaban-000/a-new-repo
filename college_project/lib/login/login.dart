// // main.dart
// // Example Flutter login UI using Provider + Dio
// // Backend: Laravel API on localhost

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:dio/dio.dart';
// import './apartments.dart';

// // =====================
// // PROVIDER
// // =====================
// class AuthProvider extends ChangeNotifier {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: 'http://10.0.2.2:8000/api', // Android Emulator
//       // use http://127.0.0.1:8000/api for iOS simulator
//       headers: {'Accept': 'application/json'},
//     ),
//   );

//   bool isLoading = false;
//   String? errorMessage;

//   Future<bool> login(String email, String password) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();

//     try {
//       final response = await _dio.post(
//         '/login',
//         data: {'email': email, 'password': password},
//       );

//       if (response.statusCode == 200) {
//         isLoading = false;
//         notifyListeners();
//         return true;
//       }
//     } on DioException catch (e) {
//       errorMessage = e.response?.data['message'] ?? 'Login failed';
//     } catch (e) {
//       errorMessage = 'Unexpected error';
//     }

//     isLoading = false;
//     notifyListeners();
//     return false;
//   }
// }

// // =====================
// // UI - LOGIN SCREEN
// // =====================
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   static final TextEditingController emailController = TextEditingController();
//   static final TextEditingController passwordController =
//       TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = context.watch<AuthProvider>();

//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Login',
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 32),
//                 TextFormField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Email is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Password is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 if (authProvider.errorMessage != null)
//                   Text(
//                     authProvider.errorMessage!,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 const SizedBox(height: 16),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: ElevatedButton(
//                     onPressed: authProvider.isLoading
//                         ? null
//                         : () async {
//                             if (_formKey.currentState!.validate()) {
//                               final success = await authProvider.login(
//                                 emailController.text,
//                                 passwordController.text,
//                               );

//                               if (success && context.mounted) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Login Successful'),
//                                   ),
//                                 );
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (ctx) => Apartments(),
//                                   ),
//                                 );
//                               }
//                             }
//                           },
//                     child: authProvider.isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text('Login'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
