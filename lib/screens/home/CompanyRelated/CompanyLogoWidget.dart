import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../apiUrl.dart';
import '../../../widgets/CustomTextWidget.dart';
import 'CompanyDetailsScreen.dart';

class CompanyLogoButton extends StatelessWidget {
  final String label;
  final String address;
  final String email;
  final String service;
  final String logoPath;
  final int Companyid;
  final String MobileNo;

  const CompanyLogoButton({super.key,
    required this.label,
    required this.address,
    required this.email,
    required this.service,
    required this.logoPath,
    required this.Companyid,
    required this.MobileNo,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        Get.to(
          CompanyDetailsPage(),
          arguments: {
            'name': label,
            'logoPath': logoPath,
            'address': address,
            'email': email,
            'service': service,
            'phone':MobileNo,
            'id':Companyid,
          },
        );
      },
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('${ApiUrl.baseUrl}$logoPath', height: screenWidth*0.3 ),
            const SizedBox(height: 10),
            CustomTextWidget(title: label.toUpperCase(), align: TextAlign.center, size: screenWidth * 0.03),
          ],
        ),
      ),
    );
  }
}