import 'package:flutter/material.dart';
import 'package:frontend/components/info_section.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width >= 800
          ? null
          : AppBar(
              title: Text("Terms And Conditions"),
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
                    title: "Acceptance of Terms",
                    content:
                        "By accessing or using our website, BECC, you agree to be bound by these Terms & Conditions. If you disagree with any part of these terms, you may not access or use the website."),
                InfoSection(
                    title: "Modifications",
                    content:
                        "We reserve the right to modify these Terms & Conditions at any time. Your continued use of the website following the posting of changes constitutes your acceptance of the revised terms."),
                InfoSection(
                    title: "User Content",
                    content:
                        "You are solely responsible for any content you submit to BECC. You may not submit content that is illegal, defamatory, obscene, or infringes on the rights of others."),
                InfoSection(
                    title: "Intellectual Property",
                    content:
                        "All content and materials available on BECC, including but not limited to text, graphics, logos, images, and software, are the property of BECC and are protected by copyright and other intellectual property laws. You may not use our content without our express written permission."),
                InfoSection(
                    title: "Disclaimer of Warranties",
                    content:
                        "The information, products, and services on BECC are provided \"as is\" and without warranties of any kind, whether express or implied. BECC does not warrant that the website will be uninterrupted or error-free, nor does it make any warranties as to the accuracy, reliability, or currency of any information provided."),
                InfoSection(
                    title: "Limitation of Liability",
                    content:
                        "In no event shall BECC, its officers, directors, employees, or agents be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, arising out of or in connection with your use of the website."),
                InfoSection(
                    title: "Termination",
                    content:
                        "We reserve the right to terminate or suspend your access to BECC for any reason, without prior notice or liability."),
                InfoSection(
                    title: "Governing Law",
                    content:
                        "These Terms & Conditions shall be governed by and construed in accordance with the laws of Jurisdiction in India, without regard to its conflict of law provisions.")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
