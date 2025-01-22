import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shift_ease_fyp/apiUrl.dart';
import '../../../Apis/PackageBuyRequestApi.dart';

class PaymentForm extends StatefulWidget {
  final String title;
  final int id;
  final int price;
  final int company;

  const PaymentForm({
    Key? key,
    required this.title,
    required this.id,
    required this.price,
    required this.company,
  }) : super(key: key);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  final PackageBuyController controller = Get.put(PackageBuyController());

  Future<void> _processPayment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final paymentData = {
        'card_number': cardNumber,
        'exp_month': expiryDate.split('/')[0],
        'exp_year': expiryDate.split('/')[1],
        'cvv': cvvCode,
        'amount': widget.price.toString(),
        'currency': 'usd',
        'package_title': widget.title,
        'package_id': widget.id.toString(),
        'company_id': widget.company.toString(),
      };

      try {
        final response = await http.post(
          Uri.parse('${ApiUrl.baseUrl}/providerapis/packagePayments/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(paymentData),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['status'] == 'success') {
            await controller.sendDataToApi(
              widget.title,
              widget.id,
              widget.price,
              widget.company,
              controller.selectedPaymentMethod.value,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment successful!')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment failed: ${responseData['message']}')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment processing failed. Please try again.')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Form'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Payment Details',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Card Number
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Card Number',
                        prefixIcon: Icon(Icons.credit_card),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) => cardNumber = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter card number' : null,
                    ),
                    const SizedBox(height: 16),

                    // Expiry Date
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Expiry Date (MM/YY)',
                        prefixIcon: Icon(Icons.date_range),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                      onSaved: (value) => expiryDate = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter expiry date' : null,
                    ),
                    const SizedBox(height: 16),

                    // CVV Code
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      onSaved: (value) => cvvCode = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter CVV' : null,
                    ),
                    const SizedBox(height: 20),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _processPayment,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.blueAccent, // Button color
                      ),
                      child: const Text(
                        'Confirm Payment',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
