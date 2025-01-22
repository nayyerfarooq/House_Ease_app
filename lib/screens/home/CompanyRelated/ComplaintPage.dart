import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/Controllers/userDataController.dart';
import 'package:shift_ease_fyp/apiUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ComplaintPage extends StatelessWidget {
  final TextEditingController complaintController = TextEditingController();
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> company = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("File a Complaint"),
        backgroundColor: Colors.red.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Company: ${company['name']}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Address: ${company['address']}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: complaintController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter your complaint...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _submitComplaint(company),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.red.shade700,
                  ),
                  child: const Text(
                    "Submit Complaint",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  void _submitComplaint(Map<String, dynamic> company) async {
    const String apiUrl = '${ApiUrl.baseUrl}/adminapis/complaints/';

    final complaintData = {
      'user_id': userController.userData['id'],
      'user_email': userController.userData['username'],
      'company_name': company['name'],
      'company_id': company['id'],
      'company_email': company['email'],
      'company_location': company['address'],
      'complaint_data': complaintController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(complaintData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Your complaint has been submitted!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.back();
      } else {
        Get.snackbar(
          "Error",
          "Failed to submit complaint. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unexpected error occurred.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
