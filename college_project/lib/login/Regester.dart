import 'dart:io';
import 'package:college_project/Screens/apartments.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Provider/AuthProvider.dart';

class Regester extends StatefulWidget {
  const Regester({super.key});

  @override
  State<Regester> createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  File? personalPhoto;
  File? idPhoto;

Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formatted =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

      setState(() {
        dateController.text = formatted;
      });
    }
  }


bool isPasswordVisible = true;
  Future<void> _pickImage(bool isPersonal) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        if (isPersonal) {
          personalPhoto = File(image.path);
        } else {
          idPhoto = File(image.path);
        }
      });
    }
  }

  Future<void> _submit(String role) async {
    if (!_formKey.currentState!.validate()) return;

    if (personalPhoto == null || idPhoto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both personal and ID photos'),
        ),
      );
      return;
    }

    final success = await context.read<AuthProvider>().register(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text,
      dateOfBirth: dateController.text.trim(),
      role: role, 
      personalPhoto: personalPhoto!,
      idPhoto: idPhoto!,
    );

    if (success && mounted) {
    
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Apartments(role: role)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

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
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Fill the form below",
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
              const SizedBox(height: 30),

              /// الصور
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _imagePicker(
                    title: "Personal Photo",
                    file: personalPhoto,
                    onTap: () => _pickImage(true),
                  ),
                  _imagePicker(
                    title: "ID Photo",
                    file: idPhoto,
                    onTap: () => _pickImage(false),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// Form Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _field("First Name", firstNameController),
                      const SizedBox(height: 16),
                      _field("Last Name", lastNameController),
                      const SizedBox(height: 16),
                      _field(
                        "Phone",
                        phoneController,
                        keyboard: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: _pickDate,
                        child: AbsorbPointer(
                          child: _field("Date of Birth", dateController),
                        ),
                      ),

                      const SizedBox(height: 16),
                      _field("Password", passwordController,
                        obscure: isPasswordVisible,
                       icon: IconButton(
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
                      ),
                      const SizedBox(height: 12),
                      if (auth.errorMessage != null)
                        Text(
                          auth.errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              _registerButton(
                title: "Register as Renter",
                role: "renter",
                onTap: _submit,
              ),
              const SizedBox(height: 16),
              _registerButton(
                title: "Register as Tenant",
                role: "tenant",
                onTap: _submit,
              ),

              if (auth.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }

  

  Widget _imagePicker({
    required String title,
    required File? file,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white,
            backgroundImage: file != null ? FileImage(file) : null,
            child: file == null
                ? const Icon(Icons.camera_alt, size: 30, color: Colors.blue)
                : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _field(
    String hint,
    TextEditingController controller, {
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
       IconButton? icon
  }) {
    return TextFormField(
      
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
            
      validator: (v) => v == null || v.isEmpty ? "$hint is required" : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        suffixIcon: icon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

 
  Widget _registerButton({
    required String title,
    required String role,
    required Function(String role) onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue.shade700,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: () => onTap(role),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
