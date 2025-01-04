import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/screens/home/CompanyRelated/CompanyLogoWidget.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import 'package:shift_ease_fyp/widgets/app_colors.dart';

class AllCompaniesScreen extends StatelessWidget {
  RxList<dynamic> companies=[].obs;

  AllCompaniesScreen({super.key, required this.companies});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        centerTitle: true,
        title: CustomTextWidget(title: 'All Companies',color: Colors.white,
            size: screenWidth * 0.045),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth < 600 ? 2 : 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: companies.length,
        itemBuilder: (context, index) {
          final company = companies[index];
          return CompanyLogoButton(
            label: company.ownerName,
            logoPath: company.logoPath,
            email: company.email,
            address: company.address,
            service: company.service,
            Companyid: company.Companyid,
            MobileNo: company.MobileNo,
          );
        },
      ),
    );
  }
}