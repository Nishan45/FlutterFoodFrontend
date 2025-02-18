import 'package:flutter/material.dart';
import 'package:frontend/components/info_section.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width >= 800
          ? null
          : AppBar(
              title: Text("About Us"),
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
                        "BECC is a premier online platform dedicated to providing high-quality dining options for students through our innovative online canteen service. We strive to deliver exceptional value to our users by offering a curated selection of popular and delicious food items, both cooked and non-cooked, ensuring a delightful and convenient dining experience."),
                InfoSection(
                    title: "Our Mission",
                    content:
                        "To provide students with access to high-quality, convenient, and affordable dining options while fostering a vibrant and satisfied student community. We aim to create an environment where students can enjoy delicious meals effortlessly, allowing them to focus on their academic and social endeavors."),
                InfoSection(
                    title: "Our Values",
                    content:
                        "At BECC, we uphold integrity, innovation, and customer-centricity as our core values. We are committed to transparency, reliability, and continuous improvement in all aspects of our operations."),
                InfoSection(
                    title: "Our Team",
                    content:
                        "Our team comprises dedicated professionals with extensive experience in frontend and backend development. Together, we work tirelessly to ensure BECC exceeds expectations and meets the evolving needs of our users."),
                InfoSection(
                    title: "Contact Us",
                    content:
                        "We are always eager to hear from you and assist with any inquiries or feedback. Please don't hesitate to reach out to us at IIEST Shibpur, India-711103, \u2709nions.civil.ug@jadavpuruniversity.in, \u27069733242529/8240757598. Your satisfaction is our priority.")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
