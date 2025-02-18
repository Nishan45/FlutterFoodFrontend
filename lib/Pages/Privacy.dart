import 'package:flutter/material.dart';
import 'package:frontend/components/info_section.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width >= 800
          ? null
          : AppBar(
              title: Text("Privacy Policy"),
              backgroundColor: Colors.white,
            ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InfoSection(
                    title: "",
                    content:
                        "BECC (\"we,\" \"our,\" or \"us\") is committed to protecting the privacy and security of your personal information. This Privacy Policy outlines how we collect, use, disclose, and safeguard your information when you visit our website and use our services."),
                InfoSection(
                    title: "Information We Collect",
                    content:
                        "We may collect personal identification information from Users in a variety of ways, including, but not limited to, when Users visit our Website, register on the Website, place an order, subscribe to the newsletter, respond to a survey, fill out a form, and in connection with other activities, services, features, or resources we make available on our Website. Users may be asked for, as appropriate, name, email address, mailing address, phone number, credit card information. Users may, however, visit our Website anonymously. We collect personal identification information from Users only if they voluntarily submit such information to us. Users can always refuse to supply personal identification information, except that it may prevent them from engaging in certain Website related activities."),
                InfoSection(
                    title: "How We Use Collected Information",
                    content:
                        "BECC may collect and use Users personal information to improve customer service, to personalize user experience, to improve our Website, to process payments, to send periodic emails"),
                InfoSection(
                    title: "How We Protect Your Information",
                    content:
                        "We adopt appropriate data collection, storage, and processing practices and security measures to protect against unauthorized access, alteration, disclosure, or destruction of your personal information, username, password, transaction information, and data stored on our Website."),
                InfoSection(
                    title: "Sharing Your Personal Information",
                    content:
                        "We do not sell, trade, or rent Users personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding visitors and users with our business partners, trusted affiliates and advertisers for the purposes outlined above."),
                InfoSection(
                    title: "Your Consent",
                    content:
                        "By using our Website, you signify your acceptance of this Privacy Policy. If you do not agree to this policy, please do not use our Website. Your continued use of the Website following the posting of changes to this policy will be deemed your acceptance of those changes."),
                InfoSection(
                    title: "Changes to This Privacy Policy",
                    content:
                        "BECC has the discretion to update this Privacy Policy at any time. We encourage Users to frequently check this page for any changes. You acknowledge and agree that it is your responsibility to review this Privacy Policy periodically and become aware of modifications."),
                InfoSection(
                    title: "Contacting Us",
                    content:
                        "If you have any questions about this Privacy Policy, the practices of this Website, or your dealings with this Website, please contact us at \u2709nions.civil.ug@jadavpuruniversity.in, \u2706 9733242529 / 8240757598"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
