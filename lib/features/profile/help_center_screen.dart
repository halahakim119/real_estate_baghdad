import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text('Help Center'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                'Welcome to the Help Center!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'At our Help Center, we strive to provide you with the best support possible. Whether you have a question, need assistance, or simply want to explore our app further, we\'re here to help!',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Our Help Center is your one-stop destination for finding answers to common questions, troubleshooting issues, and learning more about our app\'s features and functionalities. We have carefully curated a collection of articles and frequently asked questions to address the most common user inquiries.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'If you can\'t find the information you need in our articles, don\'t worry! Our dedicated support team is always ready to assist you. You can reach out to us through various channels, including phone, email, or social media. We\'re committed to ensuring your experience with our app is seamless and enjoyable.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Thank you for choosing our app. We\'re excited to have you on board, and we look forward to providing you with exceptional support.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'App Features',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              AppFeatureItem(
                icon: Icons.search,
                title:
                    'Search and filter properties by category, location, and price range',
              ),
              AppFeatureItem(
                icon: Icons.add_box,
                title: 'Create property listings with details and photos',
              ),
              AppFeatureItem(
                icon: Icons.edit,
                title: 'Edit and update your property listings',
              ),
              AppFeatureItem(
                icon: Icons.share,
                title:
                    'Share your properties with others through various channels',
              ),
              AppFeatureItem(
                icon: Icons.message,
                title: 'Send messages and inquiries to property owners',
              ),
              AppFeatureItem(
                icon: Icons.phone,
                title: 'Call property owners directly',
              ),
              AppFeatureItem(
                icon: Icons.shopping_cart,
                title: 'Get alerts for special offers and discounts',
              ),
              SizedBox(height: 20),
              Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              CustomExpansionTile(
                question: 'How do I reset my password?',
                answer: 'Answer 1',
              ),
              CustomExpansionTile(
                question: 'How can I update my account information?',
                answer: 'Answer 2',
              ),
              CustomExpansionTile(
                question:
                    'What should I do if I encounter an error while using the app?',
                answer: 'Answer 3',
              ),
              CustomExpansionTile(
                question:
                    'How do I report a bug or provide feedback about the app?',
                answer: 'Answer 4',
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
              Text('Phone: +123456789'),
              Text('Email: info@example.com'),
              Text('Facebook: facebook.com/example'),
            ],
          ),
        ),
      ),
    );
  }
}

class AppFeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const AppFeatureItem({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final String question;
  final String answer;

  const CustomExpansionTile({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: Theme.of(context).colorScheme.onSecondary,
      iconColor: Theme.of(context).colorScheme.onSecondary,
      title: Text(
        widget.question,
        style: TextStyle(
          color: isExpanded ? Colors.black : Colors.grey.shade800,
          fontSize: 14,
        ),
      ),
      trailing: isExpanded
          ?  Icon(
              Icons.expand_less,
              color: Theme.of(context).colorScheme.onSecondary,
            )
          : const Icon(
              Icons.expand_more,
            ),
      expandedAlignment: Alignment.centerLeft,
      onExpansionChanged: (bool expanding) =>
          setState(() => isExpanded = expanding),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.answer,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
