import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'privacy_policy_logic.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final PrivacyPolicyLogic logic = Get.put(PrivacyPolicyLogic());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFE8EEF0),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE8EEF0),
          elevation: 0,
          leading: IconButton(
            icon: Image.asset('images/back.png', width: 40, height: 40),
            onPressed: logic.onBack,
          ),
          title: const Text(
            'Privacy Policy',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('Introduction',
                'Digital Nomad ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application (the "App").\n\n'
                'Please read this Privacy Policy carefully. By using the App, you consent to the data practices described in this policy.'),
              const SizedBox(height: 20),
              _buildSection('1. Information We Collect',
                'We collect information that you provide directly to us and information collected automatically when you use the App:\n\n'
                '• Personal Information: Name, email address, phone number, profile picture, and other information you provide when creating an account;\n'
                '• Usage Data: Information about how you use the App, including posts, messages, interactions, and preferences;\n'
                '• Device Information: Device type, operating system, unique device identifiers, and mobile network information;\n'
                '• Location Data: With your permission, we may collect precise or approximate location information.'),
              const SizedBox(height: 20),
              _buildSection('2. How We Use Your Information',
                'We use the information we collect for various purposes, including:\n\n'
                '• Providing, maintaining, and improving the App;\n'
                '• Processing and completing transactions;\n'
                '• Sending you technical notices, updates, security alerts, and support messages;\n'
                '• Responding to your comments, questions, and requests;\n'
                '• Developing new products, services, features, and functionality;\n'
                '• Monitoring and analyzing trends, usage, and activities in connection with the App;\n'
                '• Detecting, investigating, and preventing fraudulent transactions and other illegal activities.'),
              const SizedBox(height: 20),
              _buildSection('3. Sharing of Information',
                'We may share your information in the following circumstances:\n\n'
                '• With other users: When you post content or send messages, other users may view this information;\n'
                '• With service providers: We may share information with third-party vendors who perform services on our behalf;\n'
                '• For legal reasons: We may disclose information if required by law or in response to valid requests by public authorities;\n'
                '• Business transfers: In connection with a merger, sale, or acquisition of all or a portion of our company;\n'
                '• With your consent: We may share information for any other purpose disclosed by us when you provide the information.'),
              const SizedBox(height: 20),
              _buildSection('4. Data Security',
                'We implement appropriate technical and organizational measures to protect the security of your personal information. However, please be aware that no method of transmission over the Internet or electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your personal information, we cannot guarantee its absolute security.'),
              const SizedBox(height: 20),
              _buildSection('5. Data Retention',
                'We retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law. When we no longer need your personal information, we will securely delete or anonymize it.'),
              const SizedBox(height: 20),
              _buildSection('6. Your Rights and Choices',
                'Depending on your location, you may have certain rights regarding your personal information:\n\n'
                '• Access: You can request access to your personal information;\n'
                '• Correction: You can update or correct your information through the App settings;\n'
                '• Deletion: You can request deletion of your account and associated data;\n'
                '• Opt-out: You can opt out of receiving promotional communications;\n'
                '• Data portability: You can request a copy of your data in a structured format.'),
              const SizedBox(height: 20),
              _buildSection('7. Children\'s Privacy',
                'The App is not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete such information.'),
              const SizedBox(height: 20),
              _buildSection('8. International Data Transfers',
                'Your information may be transferred to and maintained on servers located outside of your state, province, country, or other governmental jurisdiction where data protection laws may differ. If you are located outside our country and choose to provide information to us, please note that we transfer the data to our servers and process it there.'),
              const SizedBox(height: 20),
              _buildSection('9. Changes to This Privacy Policy',
                'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date. You are advised to review this Privacy Policy periodically for any changes.'),
              const SizedBox(height: 20),
              _buildSection('10. Contact Us',
                'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:\n\n'
                'Email: privacy@digitalnomad.com\n'
                'Address: Digital Nomad Inc., 123 Tech Street, San Francisco, CA 94105'),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  'Last updated: ${DateTime.now().year}-04-20',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<PrivacyPolicyLogic>();
    super.dispose();
  }
}
