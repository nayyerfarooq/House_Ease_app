import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'What is Home Ease?',
      'answer': 'Home Ease is an app that offers house shifting, renting, and decorating services.'
    },
    {
      'question': 'How do I book a house shifting service?',
      'answer': 'Go to the "Services" section, select "House Shifting," and follow the instructions to book a service.'
    },
    {
      'question': 'How do I list my house for rent?',
      'answer': 'Navigate to "My Ads" and click on "Add New Listing." Provide the required details and submit.'
    },
    {
      'question': 'What are the payment methods accepted?',
      'answer': 'Home Ease accepts all major credit and debit cards, as well as PayPal and online bank transfers.'
    },
    {
      'question': 'Can I cancel a service booking?',
      'answer': 'Yes, you can cancel a service booking by going to "My Cart," selecting the booking, and clicking on "Cancel."'
    },
    {
      'question': 'Are there any cancellation charges?',
      'answer': 'Cancellation charges may apply depending on the service provider’s policy. Check the specific terms before cancelling.'
    },
    {
      'question': 'How do I contact customer support?',
      'answer': 'You can contact customer support via the "Support" section in the app or email us at support@homeease.com.'
    },
    {
      'question': 'How do I update my profile information?',
      'answer': 'Go to "My Profile" and click on "Edit Profile" to update your personal information.'
    },
    {
      'question': 'Is my personal information secure?',
      'answer': 'Yes, we use advanced encryption and data protection measures to ensure your personal information is secure.'
    },
    {
      'question': 'How do I check the status of my service request?',
      'answer': 'You can check the status of your service request under the "My Cart" section in the app.'
    },
    {
      'question': 'What if I face an issue with the service provider?',
      'answer': 'Contact our customer support team immediately through the "Support" section. We will assist you in resolving the issue.'
    },
    {
      'question': 'Can I reschedule my house shifting service?',
      'answer': 'Yes, you can reschedule by visiting "My Cart" and selecting the option to reschedule your booking.'
    },
    {
      'question': 'How do I find houses available for rent?',
      'answer': 'Go to the "Services" section and select "House Renting" to browse through the available houses for rent.'
    },
    {
      'question': 'How do I provide feedback on a completed service?',
      'answer': 'After a service is completed, you will receive a notification to rate and review the service provider.'
    },
    {
      'question': 'Are there any special offers or discounts?',
      'answer': 'Yes, we frequently offer special promotions. Check the "Offers" section in the app for current discounts and deals.'
    },
    {
      'question': 'How do I use the house decorating service?',
      'answer': 'Navigate to the "Services" section, select "House Decorating," choose a package, and follow the instructions to book.'
    },
    {
      'question': 'What should I do if the app crashes or doesn’t work properly?',
      'answer': 'Try restarting the app or your device. If the issue persists, contact our support team through the "Support" section.'
    },
    {
      'question': 'How do I share the app with others?',
      'answer': 'Go to the "Profile" section and click on "Share App" to send a download link to your friends and family.'
    },
    {
      'question': 'What are the charges for listing my house for rent?',
      'answer': 'Listing charges vary based on the duration and type of property. Check the "My Ads" section for detailed pricing information.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ\'s',
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05), // Responsive font size
        ),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Column(
        children: [
          // Image at the top
          Container(
            width: double.infinity,
            height: screenHeight * 0.25, // Responsive height
            child: Image.asset(
              'assets/images/freq_ask.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Expanded ListView for FAQs
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Responsive margin
                  elevation: 4,
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.question_answer,
                      color: Colors.blue.shade800,
                      size: screenWidth * 0.06, // Responsive icon size
                    ),
                    title: Text(
                      faqs[index]['question']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: screenWidth * 0.045, // Responsive font size
                      ),
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
                        color: Colors.white,
                        child: Text(
                          faqs[index]['answer']!,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04, // Responsive font size
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
