import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../screen/welcome_page.dart';

class CarrierProfileController extends GetxController {
  // Form fields controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController commercialNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fleetSizeController = TextEditingController();

  // For handling loading state
  var isLoading = false.obs;


  Future<void> saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('companyName', companyNameController.text);
  }
  // Function to post the data
  Future<void> createVendor() async {
    if (isLoading.value) return;

    final String apiUrl = 'http://16.170.129.175/api/admin/vendor/create-vendor';

    // Prepare the data to be sent
    Map<String, String> data = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "phone": phoneController.text,
      "companyName": companyNameController.text,
      "commercialNumber": commercialNumberController.text,
      "address": addressController.text,
      "fleetSize": fleetSizeController.text,
    };

    // Set loading state to true
    isLoading.value = true;

    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      if (response.statusCode == 201) {
        // Parse the response data (if needed)
        var responseData = json.decode(response.body);

        // Vendor created successfully
        Get.snackbar(
          'Success',
          responseData['message'] ?? 'Vendor created successfully!',
          colorText: CupertinoColors.white,
          backgroundColor: CupertinoColors.activeGreen,
        );

        // Navigate to WelcomePage
        Get.offAll(() => WelcomePage());
      } else if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          await saveToPreferences();
          Get.offAll(() => WelcomePage());
        } else {
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Failed to create vendor',
            colorText: CupertinoColors.white,
            backgroundColor: CupertinoColors.destructiveRed,
          );
        }
      } else {
        // Handle other error responses
        var responseData = json.decode(response.body);
        Get.snackbar(
          'Error',
          responseData['message'] ?? 'Failed to create vendor',
          colorText: CupertinoColors.white,
          backgroundColor: CupertinoColors.destructiveRed,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        colorText: CupertinoColors.white,
        backgroundColor: CupertinoColors.destructiveRed,
      );
    } finally {
      // Set loading state to false
      isLoading.value = false;
    }
  }



  @override
  void onClose() {
    // Dispose the controllers when not in use
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    companyNameController.dispose();
    commercialNumberController.dispose();
    addressController.dispose();
    fleetSizeController.dispose();
    super.onClose();
  }
}
