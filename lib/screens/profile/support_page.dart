import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/support.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              children: [
                _buildSupportOption(
                  context,
                  icon: Icons.contact_mail,
                  title: 'Contact Us',
                  subtitle: 'Email: syedhussain4508@gmail.com',
                  onTap: () {
                    _sendContactEmail(); // Directly open email client
                  },
                ),
                _buildSupportOption(
                  context,
                  icon: Icons.chat,
                  title: 'Live Chat',
                  subtitle: 'Chat with our support team',
                  onTap: () {
                    (); // Open WhatsApp for live chat
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

  // Helper method to build support options
  Widget _buildSupportOption(BuildContext context,
      {required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade800, size: 28),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 14)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  // Method to send contact email
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

  // Method to open WhatsApp for live chat

  // Method to send feedback via email
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
