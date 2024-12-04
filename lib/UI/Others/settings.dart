import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_34/UI/Others/txt_screen.dart';
import 'package:tt_34/style.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List titles = <String>[
    'Terms of Use',
    'Privacy Policy',
  ];

  int _currentRating = 0;

  List descriptions = <String>[
    """Please read these Terms of Use ("Terms") carefully before using the "bfair store" mobile application (the "App") operated by [Your Company Name] ("us", "we", or "our").
By accessing or using the App, you agree to be bound by these Terms. If you disagree with any part of the Terms, then you may not access the App.
Use of the App 1.1. The App allows users to browse, purchase, and manage products and services provided by [Your Company Name]. 1.2. You must be at least 18 years old to use the App or have consent from a legal guardian.
Intellectual Property 2.1. All the content, graphics, logos, trademarks, and intellectual property rights within the App are owned by us or our licensors. 2.2. You may not copy, modify, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any part of the App without our prior written consent.
User Accounts 3.1. To access certain features or make purchases through the App, you may be required to create a user account. 3.2. You are solely responsible for maintaining the confidentiality of your account information, including your username and password. 3.3. If you suspect any unauthorized access to your account, you must immediately notify us. 3.4. We reserve the right to terminate or suspend any user accounts at our discretion without prior notice.
Privacy Policy 4.1. Our Privacy Policy governs the collection, use, and disclosure of personal information you provide while using the App. 4.2. By using the App, you consent to the collection and use of your information in accordance with our Privacy Policy.
Prohibited Activities 5.1. You agree not to engage in any of the following activities: a) Violating any applicable laws or regulations. b) Interfering with the security or functionality of the App. c) Transmitting any viruses, worms, or other malicious code. d) Impersonating any person or entity. e) Engaging in any fraudulent activity.
Disclaimer of Warranties 6.1. The App is provided on an "as-is" and "as available" basis without any warranties or representations, express or implied. 6.2. We do not guarantee that the App will be error-free, secure, or uninterrupted. 6.3. Your use of the App is at your own risk, and you agree that we shall not be liable for any damages arising out of or in connection with the use of the App.
Limitation of Liability 7.1. To the fullest extent permitted by law, we shall not be liable for any indirect, consequential, incidental, or punitive damages arising out of or in connection with the App. 7.2. In no event shall our total liability exceed the amount paid by you (if any) for using the App.
Modifications to Terms 8.1. We reserve the right to modify or replace these Terms at any time without prior notice. 8.2. By continuing to access or use the App after any revisions, you agree to be bound by the updated Terms.
Governing Law 9.1. These Terms shall be governed and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law provisions. 9.2. Any disputes arising out of or relating to these Terms shall be subject to the exclusive jurisdiction of the courts located in [Your Country/State].
By using the "bfair store" App, you acknowledge that you have read, understood, and agree to be bound by these Terms of Use.""",
    """Privacy Policy for "bfair store" Mobile Application
This Privacy Policy outlines how your information is collected, used, and shared when you use the "bfair store" mobile application (referred to as the "App").
Collection of Information: When you use the App, certain information may be collected from you, including:
Personal Information: Your name, email address, and other contact information you voluntarily provide when creating an account or contacting us through the App.
Usage Information: Information about how you use the App, your device's internet protocol (IP) address, and statistics about your activities within the App.
Device Information: Information about the device you are using, including its make, model, operating system, and unique device identifiers.
Use of Information: The information collected may be used to:
Provide and maintain the App's functionality and services.
Personalize your experience with the App and improve its features.
Communicate with you, including responding to inquiries or providing updates.
Analyze usage and trends to improve the App's performance and optimize user experience.
Sharing of Information: We may share your information with third parties for limited purposes, including:
Service Providers: We may engage third-party companies or individuals to perform functions on our behalf, such as hosting, data storage, and analysis. These service providers will have access to your information only to perform these functions and are obligated to keep it confidential.
Legal Compliance and Protection: We may disclose your information if required by law or in response to valid requests from authorized law enforcement or government agencies.
Data Security: The security of your information is important to us, and we take reasonable precautions to protect it. However, no data transmission over the internet or electronic storage is entirely secure, and we cannot guarantee absolute security.
Data Retention: We will retain your information for as long as necessary to fulfill the purposes outlined in this Privacy Policy or as required by law.
Your Choices: You have the right to access and control your personal information. You may update or delete your account information by contacting us through the contact details provided below.
Changes to this Privacy Policy: We reserve the right to modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the updated Privacy Policy within the App. Your continued use of the App after any modifications will constitute your acknowledgment and acceptance of the modified Privacy Policy.""",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      appBar: AppBar(
        backgroundColor: Style.bgColor,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                'Settings',
                style: Style.txtStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(41, 43, 72, 1),
              ),
              child: Column(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      _showCustomBottomSheet(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Contacts',
                          style: Style.txtStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      _showRatingDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rate us',
                          style: Style.txtStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TextScreen(
                            title: titles[1],
                            description: descriptions[1],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Privacy Policy',
                          style: Style.txtStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TextScreen(
                            title: titles[0],
                            description: descriptions[0],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Terms of Use',
                          style: Style.txtStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Application version',
                          style: Style.txtStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: 207,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Style.darkBlue,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Please rate us 5 stars\non the application website',
                    style: Style.txtStyle.copyWith(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        size: 35,
                        index < _currentRating ? Icons.star : Icons.star_border,
                        color:
                            index < _currentRating ? Colors.amber : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentRating = index + 1;
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 82,
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                            border: Border.all(
                              width: 1,
                              color: Color.fromRGBO(60, 169, 236, 1),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: Style.txtStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color.fromRGBO(60, 169, 236, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 82,
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(60, 169, 236, 1),
                              Color.fromRGBO(35, 119, 235, 1),
                            ]),
                            border: Border.all(
                              width: 1,
                              color: Color.fromRGBO(60, 169, 236, 1),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Send',
                              style: Style.txtStyle.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 488,
          decoration: BoxDecoration(
            color: Color.fromRGBO(41, 43, 72, 1),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Message subject',
                  hintStyle: Style.txtStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Style.bgColor,
                ),
                style: Style.txtStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                minLines: 4,
                maxLines: 5,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Message text',
                  hintStyle: Style.txtStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Style.bgColor,
                ),
                style: Style.txtStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                minLines: 4,
                maxLines: 5,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 82,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.transparent,
                        border: Border.all(
                          width: 1,
                          color: Color.fromRGBO(60, 169, 236, 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: Style.txtStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(60, 169, 236, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 82,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(60, 169, 236, 1),
                          Color.fromRGBO(35, 119, 235, 1),
                        ]),
                        border: Border.all(
                          width: 1,
                          color: Color.fromRGBO(60, 169, 236, 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Send',
                          style: Style.txtStyle.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
