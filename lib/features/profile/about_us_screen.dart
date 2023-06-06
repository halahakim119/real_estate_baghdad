import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 47, 103),
        centerTitle: true,
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'About Smart Wave Real Estate App',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Smart Wave is a leading real estate platform that aims to revolutionize the way people buy, sell, and rent properties. With our user-friendly app, we provide a seamless and efficient experience for both property seekers and sellers.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'At Smart Wave, our mission is to empower individuals and businesses in making informed real estate decisions. We strive to connect property seekers with their dream homes and assist sellers in reaching the right buyers. Our goal is to simplify the real estate process, promote transparency, and ensure customer satisfaction.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              'Key Features',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            AboutUsFeatureItem(
              icon: Icons.search,
              title: 'Advanced Property Search',
              description:
                  'Our app offers a powerful search engine with advanced filters, enabling users to find properties based on their specific requirements, such as location, price range, amenities, and more.',
            ),
            AboutUsFeatureItem(
              icon: Icons.chat,
              title: 'Direct Messaging',
              description:
                  'We facilitate direct communication between property seekers and sellers through our in-app messaging feature, allowing them to discuss details, schedule viewings, and negotiate deals.',
            ),
            AboutUsFeatureItem(
              icon: Icons.stars,
              title: 'Verified Listings',
              description:
                  'We verify the authenticity of property listings to ensure a trustworthy platform for our users. Sellers can gain credibility by providing accurate information and supporting documents.',
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any inquiries, feedback, or need assistance, our support team is available to help you. Feel free to reach out to us through the contact information provided on our website or within the app.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text('Phone: +123456789'),
            Text('Email: info@example.com'),
            Text('Facebook: facebook.com/example'),
          ],
        ),
      ),
    );
  }
}

class AboutUsFeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const AboutUsFeatureItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: const Color.fromARGB(255, 35, 47, 103)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
