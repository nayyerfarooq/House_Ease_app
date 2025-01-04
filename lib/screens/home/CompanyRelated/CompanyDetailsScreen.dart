import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/apiUrl.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';

class CompanyDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> company = Get.arguments;
    final double screenWidth = Get.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomTextWidget(
                title:company['name'].toUpperCase(),
                  color: Colors.black,
                  weight: FontWeight.w400,
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  SizedBox(
                    width: screenWidth,
                    child: Image.network(
                      '${ApiUrl.baseUrl}${company['logoPath']}',
                      width:screenWidth,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, size: 120);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Company details section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          title:company['name'].toUpperCase(),
                          size: 28,
                            weight: FontWeight.bold,
                            color: Colors.blue.shade800,
                        ),
                        const SizedBox(height: 20),
                        _buildInfoRow(
                          icon: Icons.person,
                          text: company['id'].toString(),
                          context: context,
                        ),
                        const SizedBox(height: 15),
                        _buildInfoRow(
                          icon: Icons.location_on,
                          text: company['address'],
                          context: context,
                        ),
                        const SizedBox(height: 15),
                        _buildInfoRow(
                          icon: Icons.email,
                          text: company['email'],
                          context: context,
                        ),
                        const SizedBox(height: 15),
                        _buildInfoRow(
                          icon: Icons.build,
                          text: 'Service: ${company['service']}',
                          context: context,
                        ),
                        const SizedBox(height: 15),
                        _buildInfoRow(
                          icon: Icons.phone,
                          text: 'Phone: ${company['phone']}',
                          context: context,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        shadowColor: Colors.blue.shade700,
                        elevation: 5,  // Add shadow elevation
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade700, Colors.blue.shade400],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,  // Responsive width
                            minHeight: 50,  // Minimum height of the button
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.contact_phone, color: Colors.white),  // Contact Icon
                              SizedBox(width: 10),
                              Text(
                                'Contact Us',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String text,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue.shade700),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextWidget(
           title:  text,
            size: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;

  const GlassContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: child,
      ),
    );
  }
}
