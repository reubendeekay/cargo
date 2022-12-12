import 'package:cargo/constants.dart';
import 'package:cargo/helpers/generator.dart';
import 'package:cargo/helpers/url_helper.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQQuestionScreen extends StatefulWidget {
  const FAQQuestionScreen({Key? key}) : super(key: key);

  @override
  _FAQQuestionScreenState createState() => _FAQQuestionScreenState();
}

class _FAQQuestionScreenState extends State<FAQQuestionScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  int expanded = 0;

  @override
  initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          title: FxText.titleMedium("FAQ", fontWeight: 600),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 20),
          children: <Widget>[
            ExpansionPanelList(
                expandedHeaderPadding: const EdgeInsets.all(0),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    expanded = isExpanded ? -1 : index;
                  });
                },
                animationDuration: const Duration(milliseconds: 500),
                children: List.generate(
                  faqContent.length,
                  (index) => ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: FxText.titleSmall(faqContent[index]['title'],
                              color: isExpanded
                                  ? kPrimaryColor
                                  : theme.colorScheme.onBackground,
                              fontWeight: isExpanded ? 600 : 500),
                        );
                      },
                      body: Container(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        child: Center(
                          child: FxText.bodySmall(faqContent[index]['content'],
                              fontWeight: 500),
                        ),
                      ),
                      isExpanded: expanded == index),
                )),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () async {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'mustafaibra643@gmail.com',
                    query: encodeQueryParameters(<String, String>{
                      'subject': 'FastGate Support Request'
                    }),
                  );
                  await launch(emailLaunchUri.toString());
                },
                child: Center(
                  child: FxText.bodyLarge("Still have questions?",
                      color: theme.colorScheme.primary, fontWeight: 600),
                ),
              ),
            )
          ],
        ));
  }
}

List<Map> faqContent = [
  {
    'title': 'Which countries do you currently offer services from?',
    'content':
        'We currently operate in 15 countries and 26 destinations. They include: Bahrain (Manama), Canada (Toronto), China (Guangzhou, Hongkong), Dubai (Al-Mamzar, Deira, Sharjah, Abu-Dhabi), India (Mumbai), Kenya (Nairobi, Mombasa, Eldoret, Kisumu, Nakuru), Pakistan (Karachi), Tanzania (Dar es Salaam), Thailand (Bangkok), Turkey (Istanbul), Uganda (Kampala), United Kingdom (London), United States (New York,NY; Washington DC; Dallas, TX; Atlanta, GA; Houston, TX), South Africa (Jo\'burg), Netherlands (Amsterdam).'
  },
  {
    'title': 'Do you export to the above countries as well?',
    'content':
        'Yes, we do. We offer both import and export services. We also offer door to door services.'
  },
  {
    'title': 'How do I know my freight charges?',
    'content':
        'You can get a quote by filling out the form on our website. You can also contact us via email or phone and we will be happy to assist you.'
  },
  {
    'title': 'Is my shipment insured?',
    'content':
        'Yes, all shipments are insured. We have a 100% insurance coverage on all shipments.'
  },
  {
    'title': 'How do I track my shipment?',
    'content':
        'You can track your shipment by logging into your account and clicking on the track shipment button. You can also track your shipment by clicking on the track shipment button on the home page.'
  },
  {
    'title': 'How long does it take to deliver my shipment?',
    'content':
        'It depends on the destination. For example, it takes 2-3 days to deliver to Dubai, 3-4 days to deliver to Kenya, 4-5 days to deliver to Tanzania, 5-6 days to deliver to the United States, 6-7 days to deliver to the United Kingdom, 7-8 days to deliver to Canada, 8-9 days to deliver to China, 9-10 days to deliver to India, 10-11 days to deliver to Pakistan, 11-12 days to deliver to Thailand, 12-13 days to deliver to Turkey, 13-14 days to deliver to South Africa, 14-15 days to deliver to Netherlands.'
  },
  {
    'title': 'How do I pay for my shipment?',
    'content':
        'You can pay for your shipment by logging into your account and clicking on the pay shipment button. You can also pay for your shipment by clicking on the pay shipment button on the home page.'
  },
  {
    'title': 'How do I know my shipment has been delivered?',
    'content':
        'You will receive an email notification once your shipment has been delivered.'
  },
  {
    'title': 'How do I know my shipment has been picked up?',
    'content':
        'You will receive an email notification once your shipment has been picked up.'
  },
  {
    'title': 'How do I know my shipment has been received?',
    'content':
        'You will receive an email notification once your shipment has been received.'
  },
  {
    'title': 'How do I know my shipment has been cleared?',
    'content':
        'You will receive an email notification once your shipment has been cleared.'
  },
  {
    'title': 'How do I know my shipment has been processed?',
    'content':
        'You will receive an email notification once your shipment has been processed.'
  },
  {
    'title': 'How do I know my shipment has been shipped?',
    'content':
        'You will receive an email notification once your shipment has been shipped.'
  },
  {
    'title': 'How do I know my shipment has been delivered?',
    'content':
        'You will receive an email notification once your shipment has been delivered.'
  },
];
