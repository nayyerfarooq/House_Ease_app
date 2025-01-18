import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shift_ease_fyp/Modals/CartItemsModal.dart';
import 'package:shift_ease_fyp/apiUrl.dart';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';

class PackageBuyController extends GetxController {
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
   var isLoading=false;
  User? user = FirebaseAuth.instance.currentUser;
  var CartItemData = <CartItemsModal>[].obs;
  // Function to select date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  // Function to send data to API
  Future<void> sendDataToApi(String packageName, int PackageId, int PackagePrice, int CompanyId) async {
    if (clientNameController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        dateController.text.isNotEmpty) {
      String apiUrl = "${ApiUrl.baseUrl}/providerapis/serviceBookingRequests/";
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'client_name': clientNameController.text,
          'location': locationController.text,
          'service_date': dateController.text,
          'package_name': packageName,
          'package_id': PackageId.toString(),
          'package_price': PackagePrice.toString(),
          'Company_id': CompanyId.toString(),
          'OrderPersonId': clientNameController.text,
          'request_status': 'Pending',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccessSnackbar('Request Sent Successfully');
        clientNameController.clear();
        locationController.clear();
        dateController.clear();
      } else {
        showErrorSnackbar('Something went wrong');
      }
    } else {
      showErrorSnackbar('Error: Please fill in all fields.');
    }
  }


  Future<void> getDataFromApi() async {
    String apiUrl = "${ApiUrl.baseUrl}/providerapis/ApprovedOrders/";
    var response = await http.get(Uri.parse(apiUrl));
    var isLoading= true.obs;
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body) as List;
        CartItemData.value = data.map((json) => CartItemsModal.fromJson(json)).toList();
        isLoading.value = false;
      } else {
        showErrorSnackbar('Failed to retrieve data');
        isLoading.value = false;
      }
    } catch (error) {
      showErrorSnackbar('Error: $error');
      isLoading.value = false;
    }
  }

}
