import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/view/screens/student_profile/student_profile.dart';
import 'package:flutter/material.dart';

import '../../../bottom_navbar.dart';


class MobileCatalogScreen extends StatefulWidget {
  const MobileCatalogScreen({super.key});

  @override
  State<MobileCatalogScreen> createState() => _MobileCatalogScreenState();
}

class _MobileCatalogScreenState extends State<MobileCatalogScreen> {
  // Key used to validate all fields at once
  final _formKey = GlobalKey<FormState>();

  // Controllers - one for each field, so you can read the
  // text typed by the user whenever you need it (e.g. in createPhone())
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _specsController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _storageController = TextEditingController();
  final TextEditingController _ramController = TextEditingController();
  final TextEditingController _sellerNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    // Always dispose controllers to avoid memory leaks
    _nameController.dispose();
    _priceController.dispose();
    _modelController.dispose();
    _specsController.dispose();
    _colorController.dispose();
    _conditionController.dispose();
    _brandController.dispose();
    _storageController.dispose();
    _ramController.dispose();
    _sellerNameController.dispose();
    _contactController.dispose();
    _locationController.dispose();
    super.dispose();
  }


  Future<void> _createPhone() async {
    if (!_formKey.currentState!.validate()) {
      return; // stop if any field fails validation
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Save to Firebase Firestore here
      await Future.delayed(const Duration(seconds: 2)); // simulate network call

      if (!mounted) return;
      await storeProductList(
        _nameController.text.trim(),
        _modelController.text.trim(),
        _priceController.text.trim(),
        _colorController.text.trim(),
        _conditionController.text.trim(),
        _specsController.text.trim(),
        _brandController.text.trim(),
        _storageController.text.trim(),
        _ramController.text.trim(),
        _sellerNameController.text.trim(),
        _contactController.text.trim(),
        _locationController.text.trim(),

      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavbar()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone listing created successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> storeProductList(
      String productName,
      String productModel,
      String productPrice,
      String productColor,
      String productCondition,
      String productSpecification,
      String productBrand,
      String productStorage,
      String productRAM,
      String productSeller,
      String productContact,
      String productLocation,
      ) async {
    await FirebaseFirestore.instance
        .collection("ProductList")
        .doc()
        .set({
      "productName": productName,
      "productModel": productModel,
      "productPrice": productPrice,
      "productColor": productColor,
      "productCondition": productCondition,
      "productSpecification": productSpecification,
      "brand": productBrand,
      "storage": productStorage,
      "ram": productRAM,
      "sellerName": productSeller,
      "contact": productContact,
      "location": productLocation,
      "createdAt": DateTime.now(),
    });
  }


  // Reusable field builder so every TextField looks the same
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.black54),
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          // Same soft gradient background feel as a typical sign-in screen
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF3EFFF), Colors.grey],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // Top icon, like a logo on a sign-in screen
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.phone_iphone,
                        size: 42,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'Sell Your Phone',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Center(
                    child: Text(
                      'Fill in the details below to list your phone',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // ---------- FORM FIELDS ----------
                  _buildTextField(
                    controller: _nameController,
                    label: 'Phone Name',
                    icon: Icons.smartphone,
                  ),
                  _buildTextField(
                    controller: _modelController,
                    label: 'Model',
                    icon: Icons.confirmation_number_outlined,
                  ),
                  _buildTextField(
                    controller: _priceController,
                    label: 'Price',
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    controller: _colorController,
                    label: 'Color',
                    icon: Icons.color_lens_outlined,
                  ),
                  _buildTextField(
                    controller: _conditionController,
                    label: 'Condition (e.g. New, Used)',
                    icon: Icons.verified_outlined,
                  ),
                  _buildTextField(
                    controller: _specsController,
                    label: 'Specifications',
                    icon: Icons.memory,
                    maxLines: 3,
                  ),

                  _buildTextField(
                    controller: _brandController,
                    label: 'Brand',
                    icon: Icons.branding_watermark,
                  ),
                  _buildTextField(
                    controller: _storageController,
                    label: 'Storage (e.g. 128GB)',
                    icon: Icons.sd_storage,
                  ),
                  _buildTextField(
                    controller: _ramController,
                    label: 'RAM',
                    icon: Icons.developer_board,
                  ),

                  _buildTextField(
                    controller: _sellerNameController,
                    label: 'Seller Name',
                    icon: Icons.person,
                  ),
                  _buildTextField(
                    controller: _contactController,
                    label: 'Contact Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    controller: _locationController,
                    label: 'Location / City',
                    icon: Icons.location_on,
                  ),


                  const SizedBox(height: 30),

                  // ---------- CREATE BUTTON ----------
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _createPhone,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(800),
                        ),
                        elevation: 3,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                          : const Text(
                        'CREATE',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),


                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Your Data is safe with us "),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentProfile(),
                            ),
                          );
                        },
                        child: Text(
                          "CREATE",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}