import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text('Privacy and Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrivacyPolicySection(
              title: '1. Information We Collect:',
              content: [
                'Personal Information: When you use our app, we may collect personal information such as your name, email address, phone number, and location data. This information is necessary to provide you with our services, including property listings, search functionality, and communication with property owners.',
                'Usage Information: We also collect non-personal information about your interactions with our app, such as the pages you visit, the features you use, and the actions you take. This helps us improve our app and tailor our services to your needs.',
                'Device Information: We may automatically collect device-specific information, including your device type, operating system, unique device identifier, and mobile network information. This helps us optimize our app for different devices and ensure a seamless user experience.',
                'Cookies and Similar Technologies: We may use cookies and similar technologies to track user activity, personalize your experience, and gather information about usage patterns. You have the option to disable cookies in your browser settings, but this may affect the functionality of our app.',
              ],
            ),
            SizedBox(height: 20),
            PrivacyPolicySection(
              title: '2. How We Use Your Information:',
              content: [
                'Provide and Improve Services: We use your information to deliver and enhance our services, including property search, listing management, and communication features. This includes personalizing content, recommendations, and search results based on your preferences.',
                'Communication: We may use your contact information to send you updates, notifications, and promotional materials related to our app and real estate services. You can opt-out of these communications at any time.',
                'Analytics and Research: We analyze user behavior and app usage patterns to improve our services, troubleshoot issues, and conduct market research. This information is aggregated and anonymized to ensure your privacy.',
                'Legal Compliance: We may use and disclose your information to comply with applicable laws, regulations, legal processes, or enforceable governmental requests. We will also protect our rights, privacy, safety, or property and that of our users, as required or permitted by law.',
              ],
            ),
            SizedBox(height: 20),
            PrivacyPolicySection(
              title: '3. Data Security:',
              content: [
                'We implement industry-standard security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, no data transmission over the internet or storage method can guarantee 100% security. Therefore, while we strive to protect your data, we cannot guarantee its absolute security.',
                'You are responsible for maintaining the confidentiality of your account information, including your username and password. Do not share this information with others and notify us immediately if you suspect any unauthorized access to your account.',
              ],
            ),
            SizedBox(height: 20),
            PrivacyPolicySection(
              title: '4. Third-Party Links and Services:',
              content: [
                'Our app may contain links to third-party websites, services, or advertisements that are not owned or controlled by Smart Wave. We are not responsible for the privacy practices or content of these third parties. We recommend reviewing their privacy policies before interacting with them.',
                'We may also integrate third-party services or features within our app, such as social media sharing or payment gateways. These services may collect and process information according to their own privacy policies, and we encourage you to review them.',
              ],
            ),
            SizedBox(height: 20),
            PrivacyPolicySection(
              title: '5. Children\'s Privacy:',
              content: [
                'Our app is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children. If you believe that we have inadvertently collected personal information',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicySection extends StatelessWidget {
  final String title;
  final List<String> content;

  const PrivacyPolicySection({super.key, 
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              content.map((item) => PrivacyPolicyItem(text: item)).toList(),
        ),
      ],
    );
  }
}

class PrivacyPolicyItem extends StatelessWidget {
  final String text;

  const PrivacyPolicyItem({super.key, 
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 8,
            child: Text('•'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
