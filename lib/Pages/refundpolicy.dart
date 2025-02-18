import 'package:flutter/material.dart';
import 'package:frontend/components/info_section.dart';

class Refundpolicy extends StatelessWidget {
  const Refundpolicy({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width >= 800
          ? null
          : AppBar(
              title: Text("Refund Policy"),
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
                        "Thank you for shopping at BECC. Please read this policy carefully. This is the Refund Policy of BECC."),
                InfoSection(title: "Refund Eligibility", content: '''
We offer refunds on purchases made directly through our Website http://beccafe.com/. To be eligible for a refund, the following conditions must be met:
\u2022 The refund request must be made within 30 days of the original purchase date.
\u2022 The item(s) must be unused, in the same condition that you received it, and in its original packaging.
\u2022 Proof of purchase is required.
'''),
                /*InfoSection(title: "Non-Refundable Items", content: '''
Certain items are non-refundable. These include:
\u2022 Downloadable software products once they have been downloaded or accessed.
\u2022 Gift cards.
'''),*/
                InfoSection(title: "Refund Process", content: '''
To request a refund, please contact our customer service team at \u2706 9733242529 / 8240757598. Please provide the following information:
\u2022 Your name and contact information.
\u2022 Order number.
\u2022 Reason for the refund request.
Once your request is received and reviewed, we will notify you of the approval or rejection of your refund. If approved, your refund will be processed, and a credit will automatically be applied to your credit card or original method of payment, within a certain number of days.
'''),
                InfoSection(
                    title: "Late or Missing Refunds",
                    content:
                        "If you haven’t received a refund yet, first check your bank account again. Then contact your credit card company, as it may take some time before your refund is officially posted. If you’ve done all of this and you still have not received your refund, please contact us at [9733242529 /8240757598]."),
                InfoSection(
                    title: "Exchanges",
                    content:
                        "We only replace items if they are defective or damaged. If you need to exchange it for the same item, contact us at [9733242529 /8240757598] for further instructions."),
                InfoSection(
                    title: "Shipping",
                    content:
                        "To return your product, you should mail your product to: [Telephone exchange booth, IIEST Shibpur, India-711103]. You will be responsible for paying for your own shipping costs for returning your item. Shipping costs are non-refundable. If you receive a refund, the cost of return shipping will be deducted from your refund."),
                InfoSection(
                    title: "Contacting Us",
                    content:
                        "If you have any questions about this Refund Policy, please contact us at \u2709nions.civil.ug@jadavpuruniversity.in, \u2706 9733242529 / 8240757598"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
