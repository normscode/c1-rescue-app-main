
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ralert/presentation/widgets/bulletlist.widget.dart';

@RoutePage()
class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ), 
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const Text("Terms and Conditions for the Use of RALERT",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold
                  ),  
                ),
                BulletList(const [
                  "1. Acceptance of Terms: By accessing, downloading, installing, or utilizing the RALERT application, you expressly acknowledge and agree to be bound by the terms and conditions set forth herein. If you do not agree with any part of these terms, refrain from using the application.",
                  "2. Eligibility: Use of RALERT is contingent upon your eligibility. You must be at least 18 years of age or possess the legal capacity to enter into a legally binding agreement. If you are using the application on behalf of a minor, you affirm that you have the legal authority to do so."
                  "3. Use of the Application:\na. Intended Use: RALERT is exclusively intended for the purpose of alerting emergency responders in the event of vehicular accidents. Any use outside this scope is expressly prohibited.\nb. Prohibited Activities: You agree not to engage in any activity that may compromise the integrity, security, or functionality of the RALERT application, including but not limited to unauthorized access, interference, or reverse engineering.",
                  "4. Data Collection and Privacy:\na. Data Handling: RALERT may collect and process personal information, including location data and health records, to enhance emergency response services. Such data shall be handled in strict accordance with our Privacy Policy, accessible within the RALERT application.\nb. User Control: Users retain the right to manage and control their personal information through the RALERT application's settings, as provided by applicable privacy laws and regulations.",
                  "5. Emergency Alerts:\na. Automated Alerts: RALERT is designed to automatically transmit alerts to emergency responders and selected contacts in the event of a vehicular accident.\nb. Dependent Factors: Users acknowledge that the effectiveness of emergency alerts is contingent upon factors beyond the control of RALERT, including network availability, GPS signal strength, and device functionality.",
                  "6. User Responsibilities:\na. Account Security: Users are responsible for maintaining the confidentiality of their RALERT account credentials and for all activities conducted under their accounts.\nb. Data Accuracy: Users agree to provide accurate and current information, particularly pertaining to health records, to assist emergency responders in delivering optimal medical care.",
                  "7. Limitation of Liability:\na. RALERT and its developers shall not be held liable for any direct, indirect, incidental, special, consequential, or exemplary damages, including but not limited to loss of profits, goodwill, data, or other intangible losses, arising from the use or inability to use the RALERT application.",
                  "8. Changes to Terms and Conditions:\na. RALERT reserves the right to modify or replace these terms at its discretion. Users will be notified of significant changes, and continued use of the RALERT application following such modifications constitutes acceptance of the revised terms.",
                  "9. Termination:\na. RALERT reserves the right to terminate or suspend user accounts and access to the application at its sole discretion, without prior notice or liability, for any reason whatsoever.",
                  "10. Governing Law: These terms and conditions shall be governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law provisions.Contact Information"
                ]),
          
                const SizedBox(height: 10),
          
                const Text("For inquiries regarding these terms and conditions, please contact us at ralert@gmail.com")
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}