import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Apartments_Data/appartmentsData.dart';

class ApartmentAddPage extends StatefulWidget {
  const ApartmentAddPage({super.key});

  @override
  State<ApartmentAddPage> createState() => _ApartmentAddPageState();
}

class _ApartmentAddPageState extends State<ApartmentAddPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final int? rooms = int.tryParse(roomsController.text.trim());
    final double? price = double.tryParse(
      priceController.text.trim().replaceAll(',', '.'),
    );

    if (rooms == null || price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter valid numeric values for rooms and price',
          ),
        ),
      );
      
      return;
    }

    final newApartment = Appartmentsdata(
      id: DateTime.now().millisecondsSinceEpoch,
      area: areaController.text.trim(),
      city: cityController.text.trim(),
      rooms: rooms,
      price: price,
      details: detailsController.text.trim(),

 
      image: selectedImage?.path ?? 'images/default_apartment.png',
    );

    info.add(newApartment);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Apartment added successfully!')),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f6f9),
      appBar: AppBar(
        title: const Text("Add New Apartment"),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade600,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.cyan, Colors.blue.shade600],
                  ),
                ),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: selectedImage != null
                      ? FileImage(selectedImage!)
                      : const AssetImage('images/default_apartment.png')
                            as ImageProvider,
                  child: selectedImage == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 42,
                          color: Colors.cyan,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Tap to select apartment image (optional)",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 30),

          
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _field("City", areaController, icon: Icons.map_outlined),
                    const SizedBox(height: 14),

                    _field(
                      "Area",
                      cityController,
                      icon: Icons.location_city_outlined,
                    ),
                    const SizedBox(height: 14),

                    _field(
                      "Rooms",
                      roomsController,
                      keyboard: TextInputType.number,
                      icon: Icons.bed_outlined,
                    ),
                    const SizedBox(height: 14),

                    _field(
                      "Price",
                      priceController,
                      keyboard: TextInputType.number,
                      icon: Icons.attach_money,
                    ),
                    const SizedBox(height: 14),

                    _field(
                      "Details",
                      detailsController,
                      maxLines: 4,
                      icon: Icons.description_outlined,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

        
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan.shade600,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: const Icon(Icons.add_home_outlined),
                label: const Text(
                  "Add Apartment",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String hint,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      validator: (v) => v == null || v.isEmpty ? "$hint is required" : null,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.cyan) : null,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
