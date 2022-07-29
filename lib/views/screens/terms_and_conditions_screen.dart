import 'package:flutter/material.dart';
import 'package:tmdb_app/constants.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms of Service',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  'Welcome to ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  'TMDB',
                  style: TextStyle(
                      fontSize: 18,
                      color: buttonColor,
                      fontWeight: FontWeight.bold),
                ),
              ]),
              SizedBox(
                height: 40,
              ),
              heading(16, 'Introduction'),
              SizedBox(
                height: 20,
              ),
              Text(
                  'Thank you for using the TMDB platform and the products, services and features we make available to you as part of the platform (collectively, the “Service”).'),
              SizedBox(
                height: 20,
              ),
              heading(16, 'Our Services'),
              SizedBox(
                height: 20,
              ),
              Text(
                  'The Service allows you to discover, watch and share videos and other content, provides a forum for people to connect, inform, and inspire others across the nation of Cameroon, and acts as a distribution platform for original content creators and advertisers large and small. You can also read all about enjoying content on other devices like your television, your games console, or Google Home.'),
              SizedBox(
                height: 20,
              ),
              heading(16, 'Applicable Terms'),
              SizedBox(
                height: 20,
              ),
              Text(
                  'Your use of the Service is subject to these terms, the TMDB Community Guidelines and the Policy, Safety and Copyright Policies which may be updated from time to time (together, this "Agreement"). Your Agreement with us will also include the Advertising on TMDB Policies if you provide advertising or sponsorships to the Service or incorporate paid promotions in your content. Any other links or references provided in these terms are for informational use only and are not part of the Agreement.\nPlease read this Agreement carefully and make sure you understand it. If you do not understand the Agreement, or do not accept any part of it, then you may not use the Service.'),
              SizedBox(
                height: 20,
              ),
              heading(16, 'Who may use the Service?'),
              SizedBox(
                height: 20,
              ),
              heading(14, 'Age Requirements'),
              SizedBox(
                height: 20,
              ),
              Text(
                  'You must be at least 13 years old to use the Service; however, children of all ages may use the Service if enabled by a parent or legal guardian.'),
              heading(14, 'Permission by Parent or Guardian'),
              SizedBox(
                height: 20,
              ),
              Text(
                  'If you are under 18, you represent that you have your parent or guardian’s permission to use the Service. Please have them read this Agreement with you.\nIf you are a parent or legal guardian of a user under the age of 18, by allowing your child to use the Service, you are subject to the terms of this Agreement and responsible for your child’s activity on the Service.'),
              SizedBox(
                height: 20,
              ),
              heading(14, 'Businesses'),
              SizedBox(
                height: 20,
              ),
              Text(
                  'If you are using the Service on behalf of a company or organisation, you represent that you have authority to act on behalf of that entity, and that such entity accepts this Agreement.'),
              SizedBox(
                height: 40,
              ),
              heading(16, 'Your use of the Service'),
              SizedBox(
                height: 20,
              ),
              heading(14, 'Content on the service'),
              SizedBox(
                height: 20,
              ),
              Text(
                  'The content on the Service includes videos, audio (for example music and other sounds), graphics, photos, text (such as comments and scripts), branding (including trade names, trademarks, service marks, or logos), interactive features, software, metrics, and other materials whether provided by you, YouTube or a third-party (collectively, "Content”).'),
              SizedBox(
                height: 20,
              ),
              heading(14, 'Permissions and Restrictions'),
              SizedBox(
                height: 20,
              ),
              Text(
                  'You may access and use the Service as made available to you, as long as you comply with this Agreement and applicable law. You may view or listen to Content for your personal, non-commercial use. '),
              SizedBox(
                height: 20,
              ),
              Text(
                  'The following restrictions apply to your use of the Service. You are not allowed to:'),
              SizedBox(height: 20),
              Text(
                  '1. access, reproduce, download, distribute, transmit, broadcast, display, sell, license, alter, modify or otherwise use any part of the Service or any Content except: (a) as expressly authorized by the Service; or (b) with prior written permission from TMDB and, if applicable, the respective rights holders;\n2. circumvent, disable, fraudulently engage with, or otherwise interfere with any part of the Service (or attempt to do any of these things), including security-related features or features that (a) prevent or restrict the copying or other use of Content or (b) limit the use of the Service or Content;\n3. access the Service using any automated means (such as robots, botnets or scrapers) except (a) in the case of public search engines, in accordance with TMDB robots.txt file; or (b) with TMDB prior written permission; \n4. collect or harvest any information that might identify a person (for example, usernames or faces), unless permitted by that person or allowed under section (3) above;'),
              InkWell(
                onTap: (() => Navigator.pop(context)),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text('Understood, Next'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget heading(double fontsize, String headingText) => Text(
        headingText,
        style: TextStyle(fontSize: fontsize, fontWeight: FontWeight.bold),
      );
}
