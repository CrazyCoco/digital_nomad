import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'terms_of_service_logic.dart';

class TermsOfServicePage extends StatefulWidget {
  const TermsOfServicePage({super.key});

  @override
  State<TermsOfServicePage> createState() => _TermsOfServicePageState();
}

class _TermsOfServicePageState extends State<TermsOfServicePage> {
  final TermsOfServiceLogic logic = Get.put(TermsOfServiceLogic());

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
            'Terms of Service',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('1. Acceptance of Terms', 
                'By accessing and using the Digital Nomad application ("App"), you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.'),
              const SizedBox(height: 20),
              _buildSection('2. Use License',
                'Permission is granted to temporarily download one copy of the materials on Digital Nomad\'s App for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not:\n\n'
                '• Modify or copy the materials;\n'
                '• Use the materials for any commercial purpose or for any public display;\n'
                '• Attempt to decompile or reverse engineer any software contained in the App;\n'
                '• Remove any copyright or other proprietary notations from the materials;\n'
                '• Transfer the materials to another person or "mirror" the materials on any other server.'),
              const SizedBox(height: 20),
              _buildSection('3. User Account',
                'To access certain features of the App, you may be required to create an account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to:\n\n'
                '• Provide accurate and complete information when creating your account;\n'
                '• Update your information to keep it accurate and current;\n'
                '• Protect your password and account access;\n'
                '• Notify us immediately of any unauthorized use of your account.'),
              const SizedBox(height: 20),
              _buildSection('4. User Conduct',
                'You agree to use the App only for lawful purposes. You are prohibited from:\n\n'
                '• Posting content that is illegal, harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, or otherwise objectionable;\n'
                '• Impersonating any person or entity;\n'
                '• Engaging in any activity that interferes with or disrupts the App;\n'
                '• Attempting to gain unauthorized access to any part of the App;\n'
                '• Collecting or storing personal data about other users without their consent.'),
              const SizedBox(height: 20),
              _buildSection('5. Intellectual Property',
                'The App and its original content, features, and functionality are owned by Digital Nomad and are protected by international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws. You may not reproduce, distribute, modify, create derivative works of, publicly display, publicly perform, republish, download, store, or transmit any of the material on our App.'),
              const SizedBox(height: 20),
              _buildSection('6. Termination',
                'We may terminate or suspend your account and bar access to the App immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever and without limitation, including but not limited to a breach of the Terms.\n\nUpon termination, your right to use the App will immediately cease. All provisions of the Terms which by their nature should survive termination shall survive termination.'),
              const SizedBox(height: 20),
              _buildSection('7. Limitation of Liability',
                'In no event shall Digital Nomad, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from:\n\n'
                '• Your access to or use of or inability to access or use the App;\n'
                '• Any conduct or content of any third party on the App;\n'
                '• Any content obtained from the App; and\n'
                '• Unauthorized access, use or alteration of your transmissions or content.'),
              const SizedBox(height: 20),
              _buildSection('8. Changes to Terms',
                'We reserve the right, at our sole discretion, to modify or replace these Terms at any time. By continuing to access or use our App after those revisions become effective, you agree to be bound by the revised terms.'),
              const SizedBox(height: 20),
              _buildSection('9. Contact Us',
                'If you have any questions about these Terms, please contact us at support@digitalnomad.com.'),
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
    Get.delete<TermsOfServiceLogic>();
    super.dispose();
  }
}
