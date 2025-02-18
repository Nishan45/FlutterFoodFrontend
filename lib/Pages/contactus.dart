import 'package:flutter/material.dart';
import 'package:frontend/components/info_section.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width >= 800
          ? null
          : AppBar(
              title: Text("Contact Us"),
              backgroundColor: Colors.white,
            ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoSection(
                    title: "",
                    content:
                        "We are always eager to hear from you and assist with any inquiries or feedback. Please don't hesitate to reach out to us at IIEST Shibpur, India-711103. For any queries our contact information is given below. Your satisfaction is our priority."),
                InfoSection(
                    title: "",
                    content: "\u2709 nions.civil.ug@jadavpuruniversity.in"),
                InfoSection(
                    title: "", content: "\u2706 9733242529 / 8240757598 ")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
