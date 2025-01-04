import 'package:flutter/material.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          title: 'Support',
            color: Colors.white,
            weight: FontWeight.bold,
        ),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/support.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              children: [
                _buildSupportOption(
                  context,
                  icon: Icons.contact_mail,
                  title: 'Contact Us',
                  subtitle: 'Email: syedhussain4508@gmail.com',
                  onTap: () {
                    _sendContactEmail();
                  },
                ),
                _buildSupportOption(
                  context,
                  icon: Icons.chat,
                  title: 'Live Chat',
                  subtitle: 'Chat with our support team',
                  onTap: () {
                    ();
                  },
                ),
                _buildSupportOption(
                  context,
                  icon: Icons.feedback,
                  title: 'Feedback',
                  subtitle: 'Send us your feedback',
                  onTap: () {
                    _sendFeedbackEmail();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSupportOption(BuildContext context,
      {required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade800, size: 28),
        title: CustomTextWidget(
          title:  title,
          size: 18, weight: FontWeight.bold,
        ),
        subtitle: CustomTextWidget(title: subtitle, size: 14),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _sendContactEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'syedhussain4508@gmail.com',
      queryParameters: {
        'subject': 'Customer Inquiry from Home Ease App',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  void _sendFeedbackEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@homeease.com',
      queryParameters: {
        'subject': 'Feedback for Home Ease App',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }
}
